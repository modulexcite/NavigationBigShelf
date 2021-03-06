﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SortAndFilter.ascx.cs" Inherits="BigShelf.Views.Home.SortAndFilter" %>
<%@ Register Assembly="Navigation" Namespace="Navigation" TagPrefix="nav" %>
<%@ Register Assembly="BigShelf" Namespace="BigShelf.Controls" TagPrefix="big" %>
<asp:ScriptManagerProxy ID="ScriptManager" runat="server" OnNavigate="ScriptManager_Navigate" />
<asp:UpdatePanel ID="SortAndFilterPanel" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false" RenderMode="Inline">
    <ContentTemplate>
        <div class="sortAndFilter">
            <asp:ListView ID="FilterList" runat="server" ItemType="BigShelf.Controllers.FilterViewModel" SelectMethod="GetFilterOptions" OnCallingDataMethods="Page_CallingDataMethods" ViewStateMode="Enabled">
                <LayoutTemplate>
                    <label>Show me:</label>
                    <ul><li id="itemPlaceHolder" runat="server" /></ul>
                </LayoutTemplate>
                <ItemTemplate>
                    <li>
                        <nav:NavigationHyperLink ID="filterLink" runat="server" ToData='<%# new NavigationData(){{ "filter" , Item.Filter }, { "friends" , Item.Friends }, { "page", "" }} %>' Text='<%#: Item.Text %>' Enabled='<%# Item.Enabled %>' CssClass='<%# Item.CssClass %>' Direction="Refresh" IncludeCurrentData="true" PostBack="true" ClientIDMode="AutoID" />
                    </li>
                </ItemTemplate>
            </asp:ListView>
            <asp:ListView ID="SortList" runat="server" ItemType="BigShelf.Controllers.SortViewModel" SelectMethod="GetSortOptions" OnCallingDataMethods="Page_CallingDataMethods">
                <LayoutTemplate>
                    <label>Sort by:</label>
                    <ul><li id="itemPlaceHolder" runat="server" /></ul>
                </LayoutTemplate>
                <ItemTemplate>
                    <li>
                        <nav:NavigationHyperLink ID="sortLink" runat="server" ToData='<%# new NavigationData(){{ "sort" , Item.Sort }, { "sortAscending" , Item.Ascending }, { "page", "" }} %>' Text='<%#: Item.Text %>' Enabled='<%# Item.Enabled %>' CssClass='<%# Item.CssClass %>' Direction="Refresh" IncludeCurrentData="true" PostBack="true" ClientIDMode="AutoID" />
                    </li>
                </ItemTemplate>
            </asp:ListView>
            <asp:FormView ID="SearchForm" runat="server" ItemType="BigShelf.Controllers.FilterViewModel" SelectMethod="GetSearch" UpdateMethod="SetSearch" OnCallingDataMethods="Page_CallingDataMethods" DefaultMode="Edit">
                <EditItemTemplate>
                    <asp:TextBox ID="titleText" runat="server" Text='<%# BindItem.Title %>' placeholder="Search books..." />
                    <big:AutoPostBackExtender ID="titleExtender" runat="server" TargetControlID="titleText" Trigger="keydown" Throttle="400" CommandName="Update" ClientIDMode="AutoID" />
                    <asp:Button ID="searchButton" runat="server" Text="Search" CssClass="no-js" CommandName="Update" />
                </EditItemTemplate>
            </asp:FormView>
            <asp:ListView ID="FriendsList" runat="server" ItemType="BigShelf.Controllers.FriendViewModel" SelectMethod="GetFriends" OnCallingDataMethods="Page_CallingDataMethods" ViewStateMode="Enabled">
                <LayoutTemplate>
                    <p>
                        <label>Show friends:</label>
                        <span id="itemPlaceHolder" runat="server" />
                        <asp:Button ID="friendButton" runat="server" Text="Filter" CssClass="no-js" />
                    </p>
                </LayoutTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="friendCheck" runat="server" Checked='<%# Item.Checked %>' CssClass="friend" Text='<%#: Item.Name %>' value='<%# Item.Id %>' OnCheckedChanged="friendCheck_CheckedChanged" AutoPostBack="true" ClientIDMode="AutoID" />
                </ItemTemplate>
            </asp:ListView>
        </div>
    </ContentTemplate>
    <Triggers>
        <nav:NavigationDataTrigger Key="filter" />
        <nav:NavigationDataTrigger Key="friends" />
        <nav:NavigationDataTrigger Key="sort" />
    </Triggers>
</asp:UpdatePanel>