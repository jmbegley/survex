//
//  paneldlg.h
//
//  Dialog boxes with multiple pages and a selector panel.
//
//  Copyright (C) 2002 Mark R. Shinwell
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation; either version 2 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
//

#ifndef paneldlg_h
#define paneldlg_h

#include "wx.h"
#include "paneldlgpage.h"

#include <list>

using namespace std;

class PanelDlg : public wxDialog {
    wxBoxSizer* m_VertSizer;
    wxBoxSizer* m_ButtonSizer;
    list<PanelDlgPage*> m_Pages;
    PanelDlgPage* m_CurrentPage;

    void PositionPage();

public:
    PanelDlg(wxWindow* parent, wxWindowID id, const wxString& title);
    virtual ~PanelDlg();

    void OnPageChange(wxCommandEvent&);
    void SetPages(list<PanelDlgPage*> pages);

    DECLARE_EVENT_TABLE()
};

#endif

