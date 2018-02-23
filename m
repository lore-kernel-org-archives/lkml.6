Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935756AbeBWTLO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 14:11:14 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34672 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935609AbeBWS4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 13:56:37 -0500
X-Google-Smtp-Source: AG47ELto+8NUWaASkiZgXkxXC8SKEugEi2Wo/LJF0J6YkEfUrxLz9dyt2lY/mj67KFPvWGraXCxN5Q==
From: Florian Fainelli <f.fainelli@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com,
        Markus Mayer <mmayer@broadcom.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc: ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] memory: brcmstb: dpfe: fix type declaration of variable "ret"
Date: Fri, 23 Feb 2018 10:56:32 -0800
Message-Id: <20180223185632.16733-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <1518554440-21805-3-git-send-email-mmayer@broadcom.com>
References: <1518554440-21805-1-git-send-email-mmayer@broadcom.com> <1518554440-21805-3-git-send-email-mmayer@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2018 12:40:39 -0800, Markus Mayer <mmayer@broadcom.com> wrote:
> In some functions, variable "ret" should be ssize_t, so we fix it.
> 
> Fixes: 2f330caff577 ("memory: brcmstb: Add driver for DPFE")
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---

Applied to drivers/fixes, thanks!
--
Florian
