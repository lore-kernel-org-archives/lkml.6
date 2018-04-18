Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbeDRSbW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 14:31:22 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43915 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752166AbeDRSbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 14:31:20 -0400
X-Google-Smtp-Source: AIpwx4+4Tk/UHZJDFLTF8fYawNcU9kgj3vdLj/7KUWPVq5OecHZoovUz+RMPyxMqKE6GiHj2yL0JZg==
From: Florian Fainelli <f.fainelli@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: correct SATA addresses for Stingray
Date: Wed, 18 Apr 2018 11:31:17 -0700
Message-Id: <20180418183117.14237-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <1524040889-6876-1-git-send-email-srinath.mannam@broadcom.com>
References: <1524040889-6876-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2018 14:11:29 +0530, Srinath Mannam <srinath.mannam@broadcom.com> wrote:
> Correct all SATA ahci and phy controller register
> addresses and interrupt lines to proper values.
> 
> Fixes: 344a2e514182 ("arm64: dts: Add SATA DT nodes for Stingray SoC")
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Reviewed-by: Andrew Gospodarek <andrew.gospodarek@broadcom.com>
> ---

Applied to devicetree-arm64/fixes, thanks!
--
Florian
