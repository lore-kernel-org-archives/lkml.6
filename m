Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752408AbeBIC0b (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 21:26:31 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43929 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752172AbeBIC0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 21:26:30 -0500
X-Google-Smtp-Source: AH8x225Q1oVpxHHBvtMsPlTDzam1+uPKufs2mnGOliAkpAPnItUbSKm3JOSFenQMEy8gb3j5OxqbPg==
Date: Thu, 8 Feb 2018 20:26:27 -0600
From: Rob Herring <robh@kernel.org>
To: Philippe Cornu <philippe.cornu@st.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH v1 1/2] dt-bindings/display/panel: otm8009a: Add optional
 power-supply property
Message-ID: <20180209022627.6eqhee2i37yrn33w@rob-hp-laptop>
References: <20180205094532.23547-1-philippe.cornu@st.com>
 <20180205094532.23547-2-philippe.cornu@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205094532.23547-2-philippe.cornu@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 10:45:31AM +0100, Philippe Cornu wrote:
> Some boards use a dedicated voltage regulator for this panel.
> Add & document this related optional power-supply property.
> 
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>  Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
