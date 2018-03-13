Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932641AbeCMUul (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 16:50:41 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:47810 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932257AbeCMUuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 16:50:40 -0400
X-Auth-Info: l153lvhYadfxFQh8XCGq3CMuCBSK2UL5hcI5lG14S1w=
Date: Tue, 13 Mar 2018 21:50:30 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Daniel Vetter <daniel@ffwll.ch>,
        yannick fertre <yannick.fertre@st.com>
Cc: Vikas Manocha <vikas.manocha@st.com>, Tom Rini <trini@konsulko.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Philippe Cornu <philippe.cornu@st.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Patrick DELAUNAY <patrick.delaunay@st.com>,
        Christophe KERELLO <christophe.kerello@st.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Brian Norris <briannorris@chromium.org>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>, Simon Glass <sjg@chromium.org>,
        u-boot@lists.denx.de, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 00/10] splash screen on the stm32f769 disco board
Message-ID: <20180313214737.62ef82c8@crub>
In-Reply-To: <20180313152310.GJ4788@phenom.ffwll.local>
References: <1520949014-21468-1-git-send-email-yannick.fertre@st.com>
        <20180313152310.GJ4788@phenom.ffwll.local>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2018 16:23:10 +0100
Daniel Vetter daniel@ffwll.ch wrote:
...
> Shouldn't we patch the drivers/gpu/drm/stm driver instead of the
> drivers/video one? fbdev is kinda a dead end and not for adding new hw
> support ...

this patch series adds display driver to U-Boot project, I don't know
why it was submitted to the Linux kernel and dri-devel mailing lists.

Yannick, please don't send this to linux-kernel and dri-devel lists
and also please don't Cc kernel developers when resubmitting the
patch series.

--
Anatolij
