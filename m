Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932213AbeBACDj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 21:03:39 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40762 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932137AbeBACDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 21:03:37 -0500
X-Google-Smtp-Source: AH8x226wEvP8jyYwr+zvihUNxC4XSxuP2TyImjbwzxrVKnhJyTkUoXtzWxA5+ls8rGGQwyddqMsQ6A==
Date: Wed, 31 Jan 2018 21:03:32 -0500
From: Arvind Sankar <nivedita@alum.mit.edu>
To: Rob Landley <rob@landley.net>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        initramfs <initramfs@vger.kernel.org>,
        Taras Kondratiuk <takondra@cisco.com>,
        Victor Kamensky <kamensky@cisco.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] rootfs: force mounting rootfs as tmpfs
Message-ID: <20180201020331.GA3774@rani.riverdale>
References: <1517348777.3469.5.camel@linux.vnet.ibm.com>
 <1814af5c-170d-39c0-58fd-02eb7216e008@landley.net>
 <1517436423.3469.237.camel@linux.vnet.ibm.com>
 <a538e55c-81ca-6d59-20cf-21b47387c3e2@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a538e55c-81ca-6d59-20cf-21b47387c3e2@landley.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 05:48:20PM -0600, Rob Landley wrote:
> On 01/31/2018 04:07 PM, Mimi Zohar wrote:
> > On Wed, 2018-01-31 at 13:32 -0600, Rob Landley wrote:>> (The old "I configured in tmpfs and am using rootfs but I want that
> rootfs
> >> to be ramfs, not tmpfs" code doesn't seem to be a real-world concern, does
> >> it?)
> > 
> > I must be missing something.  Which systems don't specify "root=" on
> > the boot command line.
> 
> Any system using initrd or initramfs?
> 

Don't a lot of initramfs setups use root= to tell the initramfs which
actual root file system to switch to after early boot?
