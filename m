Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbeEQQCP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:02:15 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33999 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbeEQQCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:02:13 -0400
X-Google-Smtp-Source: AB8JxZpMYfyrrAjgiU4pJKhTB6oim+FOfvdIhIctDk+Gn9MMpbouE0UPZAFf1rx+fHwLKtD+tE94tQ==
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Thu, 17 May 2018 12:02:08 -0400 (EDT)
X-X-Sender: vince@macbook-air
To: Eric Anholt <eric@anholt.net>
cc: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm: bcm2835: Add the PMU to the devicetree.
In-Reply-To: <87efia1hjg.fsf@anholt.net>
Message-ID: <alpine.DEB.2.21.1805171159110.7984@macbook-air>
References: <20180517131727.29263-1-eric@anholt.net> <alpine.DEB.2.21.1805171007260.7820@macbook-air> <87efia1hjg.fsf@anholt.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2018, Eric Anholt wrote:
> 
> Is that better than a53?  I'm happy to switch to that.  The important
> part to me is the a7, since basically everyone with this hw is running
> arm32.

no, on further investigation it looks like a53 is more proper to use than 
the generic armv8.

Is the armv8 pmu on the cortex-a53 backwards compatible with armv7?  I'm 
dreading having to pull up the various ARM ARMs to look for myself so if 
it works for you I'm fine with that part too.

The biggest pushback I had with my original patch was no one believing irq 
9 was the right one to use.

Vince
