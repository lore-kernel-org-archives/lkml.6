Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033361AbeBNRGL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:06:11 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38037 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032907AbeBNRGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:06:09 -0500
X-Google-Smtp-Source: AH8x224Ep5ExHF70VziLFwt6ElqDqG2BW6cKr3kaX/UPrMYl3sYDMg9GoqYEaaI5hcSasiyH2ZWF3A==
Date: Wed, 14 Feb 2018 09:06:04 -0800
In-Reply-To: <1518624432-15110-2-git-send-email-d.schultz@phytec.de>
References: <1518624432-15110-1-git-send-email-d.schultz@phytec.de> <1518624432-15110-2-git-send-email-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH v3 2/2] net: phy: dp83867: Add documentation for CLK_OUT pin muxing
To: Daniel Schultz <d.schultz@phytec.de>, robh+dt@kernel.org,
        mark.rutland@arm.com, andrew@lunn.ch, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
CC: w.egorov@phytec.de
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6E67A8CE-27A7-44F8-A325-85A61AB393EE@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1EH6Fgx018342

On February 14, 2018 8:07:12 AM PST, Daniel Schultz <d.schultz@phytec.de> wrote:
>From: Wadim Egorov <w.egorov@phytec.de>
>
>Add documentation of ti,clk-output-sel which can be used to select
>a specific clock for CLK_OUT.
>
>Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
>Signed-off-by: Daniel Schultz <d.schultz@phytec.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Nit: usually the binding patch comes first and the implementation using it right after, not necessary to respin.

-- 
Florian
