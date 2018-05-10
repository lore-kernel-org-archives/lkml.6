Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966557AbeEJPuW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:50:22 -0400
Received: from imap.thunk.org ([74.207.234.97]:56538 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966203AbeEJPuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:50:20 -0400
Date: Thu, 10 May 2018 11:50:16 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Mathieu Malaterre <malat@debian.org>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: make =?utf-8?Q?function_?=
 =?utf-8?B?4oCYZXh0NF9nZXRmc21hcF9maW5kX2ZpeGVkX21ldGFkYXRh4oCZ?= static
Message-ID: <20180510155016.GC8335@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Mathieu Malaterre <malat@debian.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180505200452.18962-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180505200452.18962-1-malat@debian.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2018 at 10:04:52PM +0200, Mathieu Malaterre wrote:
> Since function ‘ext4_getfsmap_find_fixed_metadata’ can be made static,
> make it so. Remove the following gcc warning (W=1):
> 
>   fs/ext4/fsmap.c:405:5: warning: no previous prototype for ‘ext4_getfsmap_find_fixed_metadata’ [-Wmissing-prototypes]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied, thanks.

						- Ted
