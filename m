Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755122AbeDZTUq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 15:20:46 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:36820 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751809AbeDZTUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 15:20:43 -0400
X-Google-Smtp-Source: AIpwx4/A1J6XNrIiNKYhCbf+wK7dWZ3/ipqXRde2yaEWvMRUvHRF1n0uLQMeIpKy9LweJqwCnOLKog==
Date: Thu, 26 Apr 2018 12:20:40 -0700
From: Tejun Heo <tj@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-ide@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "ata: ahci-platform: add reset control support"
Message-ID: <20180426192040.GT1911913@devbig577.frc2.facebook.com>
References: <1523237554-7928-1-git-send-email-hayashi.kunihiko@socionext.com>
 <c8ec7474-7eb4-24cf-1f53-b4bcee5508dd@redhat.com>
 <20180418083647.GA5503@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418083647.GA5503@ulmo>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Apr 18, 2018 at 10:36:47AM +0200, Thierry Reding wrote:
> I see that you've applied this to your for-next branch. However, this is
> a fix that needs to go into v4.17 because that's where the regression
> was introduced. Is there any way you can promote this to a fixes branch?

It's in for-4.17-fixes.  I'll push it out early next week.

Thanks.

-- 
tejun
