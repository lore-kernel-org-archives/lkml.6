Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752939AbeDPWRS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 18:17:18 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45974 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752620AbeDPWRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 18:17:06 -0400
X-Google-Smtp-Source: AIpwx4/NHSiEyI9d6TNGHKZU1sH4TfTPETGYjMWwxjUebxN9yT7UBURaMdKJq/M6ZgijCPBlKKJcmA==
From: Florian Fainelli <f.fainelli@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Cc: opendmb@gmail.com, Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: B15: Update to support Brahma-B53
Date: Mon, 16 Apr 2018 15:16:48 -0700
Message-Id: <20180416221648.31573-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180223204110.6350-1-f.fainelli@gmail.com>
References: <20180223204110.6350-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Feb 2018 12:41:10 -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The B53 CPU design supports up to 8 processors, which moved the RAC_FLUSH_REG
> offset 0x4 bytes below to make room for a RAC_CONFIG2_REG to control RAC
> settings for CPU4-7.
> 
> Lookup the processor type (B15 or B53) and adjust the RAC_FLUSH_REG offset
> accordingly, if we do not know the processor, bail out.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to soc/next, thanks!
--
Florian
