Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeBHC0R (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 21:26:17 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:32829 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751554AbeBHC0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 21:26:15 -0500
X-ME-Sender: <xms:RrV7WnlaZMo3hIS9zyJN7bCIHL-9wqXwtcjMbLxEMQGkBGzvnvbmaQ>
Date: Thu, 8 Feb 2018 13:26:11 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org
Subject: Re: [PATCH 0/8] Clean up kernel-doc and fix literal-block handling
Message-ID: <20180208022611.GA3304@eros>
References: <20180207172624.24555-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207172624.24555-1-corbet@lwn.net>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 10:26:16AM -0700, Jonathan Corbet wrote:
> So once upon a time I set out to fix the problem reported by Tobin wherein
> a literal block within a kerneldoc comment would be corrupted in
> processing.  On the way, though, I got annoyed at the way I have to learn
> how kernel-doc works from the beginning every time I tear into it.

Awesome. The patch that exposed that problem hasn't landed yet but I
tested this series and can confirm that it fixes it.

FTR to test I did:

- update function docs for include/linux/rcupdate.h:rcu_pointer_hadoff()

  	removed enclosing '``' and added leading '::'

- apply this series
- rebuild docs
- profit

thanks,
Tobin.
