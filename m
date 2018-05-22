Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751738AbeEVSMq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 14:12:46 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39012 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751609AbeEVSMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 14:12:44 -0400
X-Google-Smtp-Source: AB8JxZo4dagHze9/7dUNWFiDMBVxLeiQoYaeXDgbZoaw65nnd/NHTPehTvzJo7WpOuv9j1JxmfdY+A==
From: Florian Fainelli <f.fainelli@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com,
        Scott Branden <scott.branden@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: specify 1.8V EMMC capabilities for bcm958742t
Date: Tue, 22 May 2018 11:12:41 -0700
Message-Id: <20180522181241.12745-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <1527008499-4120-1-git-send-email-scott.branden@broadcom.com>
References: <1527008499-4120-1-git-send-email-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2018 10:01:39 -0700, Scott Branden <scott.branden@broadcom.com> wrote:
> Specify 1.8V EMMC capabilities for bcm958742t board to indicate support
> for UHS mode.
> 
> Fixes: d4b4aba6be8a ("arm64: dts: Initial DTS files for Broadcom Stingray SOC")
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---

Applied to devicetree-arm64/fixes, thanks!
--
Florian
