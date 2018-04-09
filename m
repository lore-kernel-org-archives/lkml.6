Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbeDIWM0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 18:12:26 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:35053 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbeDIWMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 18:12:22 -0400
X-Google-Smtp-Source: AIpwx49J/T361yrsX7bFVgS16YKP25E5SCh67BqEOCfL979MZzLdBFGjoJRB9EcUcTeGwWckf6txqw==
Date: Mon, 9 Apr 2018 15:12:18 -0700
From: Tejun Heo <tj@kernel.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "ata: ahci-platform: add reset control support"
Message-ID: <20180409221218.GJ3126663@devbig577.frc2.facebook.com>
References: <1523237554-7928-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523237554-7928-1-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 10:32:34AM +0900, Kunihiko Hayashi wrote:
> This reverts commit f0f56716fc3e5d547fd7811eb218a30ed0695605.
> 
> According to Thierry's view,
> https://www.spinics.net/lists/linux-ide/msg55357.html
> some hardware-specific drivers already use their own resets,
> and the common reset might make a path to occur double controls of resets.
> 
> For now, revert the commit that adds reset control support to ahci-platform,
> and hold until the solution is confirmed not be affect all hardware-specific
> drivers.
> 
> Fixes: f0f56716fc3e ("ata: ahci-platform: add reset control support")
> Reported-by: Thierry Reding <thierry.reding@gmail.com>
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Applied to libata/for-4.17-fixes.

Thanks.

-- 
tejun
