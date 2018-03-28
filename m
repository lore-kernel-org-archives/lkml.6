Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753360AbeC1Ssj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 14:48:39 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45068 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbeC1Ssg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 14:48:36 -0400
X-Google-Smtp-Source: AIpwx49mJWqmkiqrypB3C+2M+dM5HDykbk1hWMeaRjiWtHHgUKOaW1lOKHO0UwzQFtc0teYiG9Ob6w==
From: Florian Fainelli <f.fainelli@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Cc: Markus Mayer <mmayer@broadcom.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memory: brcmstb: dpfe: Remove need for dpfe_dev
Date: Wed, 28 Mar 2018 11:48:33 -0700
Message-Id: <20180328184833.23369-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180327234038.32241-1-f.fainelli@gmail.com>
References: <20180327234038.32241-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2018 16:40:38 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> We can hook sysfs objects to the parent platform device that we are
> created from, no need to have a synthetic dpfe_dev just for that. This
> incidentally removes the need for having an index, since we are
> guaranteed to have an unique path in the sysfs hiearchy.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to drivers/next, thanks!
--
Florian
