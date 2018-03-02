Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427791AbeCBS6H (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 13:58:07 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:54373 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422764AbeCBS6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 13:58:05 -0500
X-Google-Smtp-Source: AG47ELvUpMzWGN7W92h2cDQxk+nnazDsioz0X2PAM2NRRR80bcqdSYdBbTVUlUZRX6cpGNfMrXbIiA==
Date: Fri, 2 Mar 2018 10:58:01 -0800
From: Brian Norris <briannorris@chromium.org>
To: yannick fertre <yannick.fertre@st.com>
Cc: Vikas Manocha <vikas.manocha@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Philippe Cornu <philippe.cornu@st.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Patrick DELAUNAY <patrick.delaunay@st.com>,
        Christophe KERELLO <christophe.kerello@st.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Bhumika Goyal <bhumirks@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Albert Aribaud <albert.u.boot@aribaud.net>,
        Simon Glass <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>,
        Thierry Reding <thierry.reding@gmail.com>, u-boot@lists.denx.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/10] video: add MIPI DSI host controller bridge
Message-ID: <20180302185759.GA114194@rodete-desktop-imager.corp.google.com>
References: <1520005451-23217-1-git-send-email-yannick.fertre@st.com>
 <1520005451-23217-6-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520005451-23217-6-git-send-email-yannick.fertre@st.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 02, 2018 at 04:44:06PM +0100, yannick fertre wrote:
> Add a Synopsys Designware MIPI DSI host bridge driver, based on the
> Rockchip version from rockchip/dw-mipi-dsi.c with phy & bridge APIs.

How many times are we going to allow copy-and-pasting the same driver?
Last time we wanted to modify the Rockchip driver, we were told
"consolidate", because ST had already forked our driver. This nearly
halted all progress. I'm going to be real disappointed if we see another
fork get merged.

(IOW, I would say "over my dead body," but I have no power here.)

And why can't you use DRM?

Brian
