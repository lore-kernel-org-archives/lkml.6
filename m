Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751071AbeDMR6S (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 13:58:18 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:38641 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbeDMR6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 13:58:16 -0400
X-Google-Smtp-Source: AIpwx48piiU+xj/9xuBE8d0bf9DmU+ZyoYPMrvJ7zoqX/R8OLcT58OeKqkeZrHC6D8Qr6TyKaZJqAQ==
Date: Fri, 13 Apr 2018 12:58:14 -0500
From: Rob Herring <robh@kernel.org>
To: Philippe Cornu <philippe.cornu@st.com>
Cc: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yannick Fertre <yannick.fertre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH 1/2] dt-bindings/display/bridge: sii902x: add optional
 power supplies
Message-ID: <20180413175814.7jzrqczll5o3c62i@rob-hp-laptop>
References: <20180410051927.8268-1-philippe.cornu@st.com>
 <20180410051927.8268-2-philippe.cornu@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410051927.8268-2-philippe.cornu@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 07:19:26AM +0200, Philippe Cornu wrote:
> Add the 3 optional power supplies using the exact description
> found in the document named
> "SiI9022A/SiI9024A HDMI Transmitter Data Sheet (August 2016)".
> 
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>  Documentation/devicetree/bindings/display/bridge/sii902x.txt | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
