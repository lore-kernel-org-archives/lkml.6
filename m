Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbeDIPpJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 11:45:09 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:42532 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753036AbeDIPpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 11:45:08 -0400
X-Google-Smtp-Source: AIpwx49cM8+qCN82xj/ZZStq0DAYF+qP0GxscCOJyzosLhjf5yNgLVl0zDA8KeraUEMg6O7xKg021g==
Date: Mon, 9 Apr 2018 10:45:06 -0500
From: Rob Herring <robh@kernel.org>
To: Fabien Dessenne <fabien.dessenne@st.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Ludovic Barre <ludovic.barre@st.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: mailbox: add STMicroelectronics
 STM32 IPCC binding
Message-ID: <20180409154506.fszkflmyhprd5ztk@rob-hp-laptop>
References: <1523269706-23724-1-git-send-email-fabien.dessenne@st.com>
 <1523269706-23724-2-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523269706-23724-2-git-send-email-fabien.dessenne@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 12:28:25PM +0200, Fabien Dessenne wrote:
> Add a binding for the STMicroelectronics STM32 IPCC block exposing a
> mailbox mechanism between two processors.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  .../devicetree/bindings/mailbox/stm32-ipcc.txt     | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt

Please add acks/reviewed-bys when posting new versions.

Rob
