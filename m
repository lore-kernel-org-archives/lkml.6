Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754324AbeDIVQ5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 17:16:57 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:33190 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752432AbeDIVQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 17:16:55 -0400
X-Google-Smtp-Source: AIpwx4+q1YhaujSnKRxCUbbb+JUenzulFEgg4Fd49H8+ei7XoCE17GAg4q1ZijqyL8gxSTUXJABfAg==
Date: Mon, 9 Apr 2018 16:16:52 -0500
From: Rob Herring <robh@kernel.org>
To: sean.wang@mediatek.com
Cc: mark.rutland@arm.com, marcel@holtmann.org, johan.hedberg@gmail.com,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/7] dt-bindings: net: bluetooth: Add
 mediatek-bluetooth
Message-ID: <20180409211652.etq6ylp63b7j65el@rob-hp-laptop>
References: <cover.1522736996.git.sean.wang@mediatek.com>
 <958f8a0ef0b557fdfcc02a1e86536e1f97a16e22.1522736996.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <958f8a0ef0b557fdfcc02a1e86536e1f97a16e22.1522736996.git.sean.wang@mediatek.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 03:15:51PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add binding document for a SoC built-in device using MediaTek protocol.
> Which could be found on MT7622 SoC or other similar MediaTek SoCs.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../devicetree/bindings/net/mediatek-bluetooth.txt | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/mediatek-bluetooth.txt

Reviewed-by: Rob Herring <robh@kernel.org>
