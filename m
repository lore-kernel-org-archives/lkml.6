Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752907AbeCMVFQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 17:05:16 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39653 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752431AbeCMVFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 17:05:14 -0400
X-Google-Smtp-Source: AG47ELvav4k7a22afrFpKqORvXI5L+pD6aznUzRB3s5VT8+0NdnbYPnTxM4J3okxOmntN7FZ+0vfTw==
MIME-Version: 1.0
In-Reply-To: <20180313214737.62ef82c8@crub>
References: <1520949014-21468-1-git-send-email-yannick.fertre@st.com>
 <20180313152310.GJ4788@phenom.ffwll.local> <20180313214737.62ef82c8@crub>
From: Brian Norris <briannorris@chromium.org>
Date: Tue, 13 Mar 2018 14:00:04 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNJ6pq5FZfg+KDNNFQVv+r=FAimkeW5C8tJ9VQTb4xhMg@mail.gmail.com>
Message-ID: <CA+ASDXNJ6pq5FZfg+KDNNFQVv+r=FAimkeW5C8tJ9VQTb4xhMg@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] splash screen on the stm32f769 disco board
To: Anatolij Gustschin <agust@denx.de>
Cc: Daniel Vetter <daniel@ffwll.ch>,
        yannick fertre <yannick.fertre@st.com>,
        Vikas Manocha <vikas.manocha@st.com>, Tom Rini <trini@konsulko.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Philippe Cornu <philippe.cornu@st.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Patrick DELAUNAY <patrick.delaunay@st.com>,
        Christophe KERELLO <christophe.kerello@st.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>, Simon Glass <sjg@chromium.org>,
        u-boot@lists.denx.de, Linux Kernel <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 1:50 PM, Anatolij Gustschin <agust@denx.de> wrote:
> On Tue, 13 Mar 2018 16:23:10 +0100
> Daniel Vetter daniel@ffwll.ch wrote:
> ...
>> Shouldn't we patch the drivers/gpu/drm/stm driver instead of the
>> drivers/video one? fbdev is kinda a dead end and not for adding new hw
>> support ...
>
> this patch series adds display driver to U-Boot project, I don't know
> why it was submitted to the Linux kernel and dri-devel mailing lists.
>
> Yannick, please don't send this to linux-kernel and dri-devel lists
> and also please don't Cc kernel developers when resubmitting the
> patch series.

I couldn't agree more! I mentioned this on the previous confusing post
(where I had the same objection as Daniel, before realizing this was
just a poorly-documented, ill-targeted U-Boot patch series).

Brian
