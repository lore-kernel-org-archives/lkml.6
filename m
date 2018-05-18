Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbeERRDd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 13:03:33 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39900 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbeERRD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 13:03:29 -0400
X-Google-Smtp-Source: AB8JxZrUCDC7c99sR2mBb6WwVgI04JfgK6SiA+gDIec75Fh5vWbXEEfaR2iE/wscPN6lvYbXWPXnNA==
From: Florian Fainelli <f.fainelli@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com,
        Scott Branden <scott.branden@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: specify 1.8V EMMC capabilities for bcm958742k
Date: Fri, 18 May 2018 10:03:26 -0700
Message-Id: <20180518170326.8452-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <1526656880-8795-1-git-send-email-scott.branden@broadcom.com>
References: <1526656880-8795-1-git-send-email-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2018 08:21:20 -0700, Scott Branden <scott.branden@broadcom.com> wrote:
> Specify 1.8V EMMC capabilities for bcm958742k board to indicate support
> for UHS mode.
> 
> Fixes: d4b4aba6be8a ("arm64: dts: Initial DTS files for Broadcom Stingray SOC")
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---

Applied to devicetree-arm64/fixes, thanks!
--
Florian
