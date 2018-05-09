Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964899AbeEISbo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 14:31:44 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:41036 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933577AbeEISbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 14:31:42 -0400
X-Google-Smtp-Source: AB8JxZoR6I80ccmtqVw34n8HiUAJSfbVsIE55XwpD6RHZdcXK33ae8qKmiGhdRsWyNANIy9iOwgG2A==
Date: Wed, 9 May 2018 13:31:40 -0500
From: Rob Herring <robh@kernel.org>
To: frowand.list@gmail.com
Cc: pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v2] MAINTAINERS: add keyword for devicetree overlay
 notifiers
Message-ID: <20180509183140.GA11580@rob-hp-laptop>
References: <1524879080-27111-1-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524879080-27111-1-git-send-email-frowand.list@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 06:31:20PM -0700, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Devicetree overlay notifiers have a chance to potentially get
> pointers into the overlay unflattened devicetree and overlay FDT.
> The only protection against these pointers being accessed after
> the underlying data has been released by kfree() is by source
> code review of patches.  Add a keyword line to the devicetree
> overlay maintainers entry to try to catch overlay notifier
> related patches.
> 
> The keyword line is added to the devicetree overlay entry instead
> of the devicetree entry so that not all maintainers will receive
> the additional review traffic.  Add Frank Rowand (already a
> maintainer in the devicetree entry) so that he will receive
> the additional review traffic.
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> changes from version 1:
>    - removed extraneous "From:" tags at top of patch description

Applied, sorry it fell thru the cracks.

Rob
