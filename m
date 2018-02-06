Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752469AbeBFBoC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 20:44:02 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45441 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbeBFBn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 20:43:56 -0500
X-Google-Smtp-Source: AH8x224g9SLl09t/0zZUVAcxrscywmllmJDbK/W9OZDFyy/qZnaFiG9UCeYhLTtmvPLGbSFOPbIiyA==
Date: Mon, 5 Feb 2018 17:43:52 -0800
From: Brian Norris <briannorris@chromium.org>
To: Philippe CORNU <philippe.cornu@st.com>
Cc: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Bhumika Goyal <bhumirks@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sandy Huang <hjc@rock-chips.com>, Heiko Stubner <heiko@sntech.de>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org"
        <linux-rockchip@lists.infradead.org>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ludovic BARRE <ludovic.barre@st.com>,
        Mickael REULIER <mickael.reulier@st.com>
Subject: Re: [PATCH] drm/bridge/synopsys: dsi: Add 1.31 version support
Message-ID: <20180206014351.GA110153@ban.mtv.corp.google.com>
References: <20180122150819.22066-1-philippe.cornu@st.com>
 <37f38992-0ad3-317f-5337-fbe018bf5f45@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37f38992-0ad3-317f-5337-fbe018bf5f45@st.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 10:19:15PM +0000, Philippe CORNU wrote:
> Hi Archit, Andrzej, Laurent & Brian,
> 
> What is your opinion regarding this patch? Do you have any advice for 
> handling hw versions?
> 
> Do not hesitate to comment.

I'll admit, I don't really have the bandwidth to handle this. I also
haven't looked into any version diffs to know the extent of changes
between HW versions.

Brian
