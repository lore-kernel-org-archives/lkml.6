Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965278AbeBWTMK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 14:12:10 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36548 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754439AbeBWS4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 13:56:24 -0500
X-Google-Smtp-Source: AG47ELuojYx1G+IFHfypiBdlz+U4/8Jp7pRu3jrwi30HTna9bluTcpP00/dEdy33jInvPFPV7U11Eg==
From: Florian Fainelli <f.fainelli@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com,
        Markus Mayer <mmayer@broadcom.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc: ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] memory: brcmstb: dpfe: properly mask vendor error bits
Date: Fri, 23 Feb 2018 10:56:09 -0800
Message-Id: <20180223185609.16641-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <1518554440-21805-2-git-send-email-mmayer@broadcom.com>
References: <1518554440-21805-1-git-send-email-mmayer@broadcom.com> <1518554440-21805-2-git-send-email-mmayer@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2018 12:40:38 -0800, Markus Mayer <mmayer@broadcom.com> wrote:
> We were printing the entire 32 bit register rather than just the lower
> 8 bits. Anything above bit 7 is reserved and may be any random value.
> 
> Fixes: 2f330caff577 ("memory: brcmstb: Add driver for DPFE")
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---

Applied to drivers/fixes, thanks!
--
Florian
