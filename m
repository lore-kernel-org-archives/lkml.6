Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752920AbeCMSBE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 14:01:04 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35257 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752871AbeCMSA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 14:00:56 -0400
X-Google-Smtp-Source: AG47ELsewSq7fXULhKqIjW+854182vYW0/GUPf8n4o+8LSjT2frQKvHbXGtHLiXXK8twLGPRWEcuIw==
Date: Tue, 13 Mar 2018 11:00:52 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Thierry Escande <thierry.escande@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] arm64: dts: apq8096-db820c: enable bluetooth node
Message-ID: <20180313180052.GV18510@minitux>
References: <20180313164444.19881-1-thierry.escande@linaro.org>
 <20180313164444.19881-2-thierry.escande@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313164444.19881-2-thierry.escande@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13 Mar 09:44 PDT 2018, Thierry Escande wrote:

> Add a new serial node for the Qualcomm BT controller QCA6174. This
> allows automatic probing and hci registration through the serdev
> framework instead of relying on the userspace helpers.
> 
> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
