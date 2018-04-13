Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751002AbeDMStm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 14:49:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:48122 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750761AbeDMStk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 14:49:40 -0400
Date: Fri, 13 Apr 2018 20:49:37 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Sam Hansen <hansens@google.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/i2c: sync docs with current state of
 i2c-tools.
Message-ID: <20180413204937.440437e9@endymion>
In-Reply-To: <CAP9bUy7rONNHYeRkYtaWHcfqoZcGKXJz-JocED26zBj9n+-ZbQ@mail.gmail.com>
References: <20180412213342.138010-1-hansens@google.com>
        <20180412222457.x4jdwt27ylgi74o3@katana>
        <20180413141359.793919fb@endymion>
        <CAP9bUy7rONNHYeRkYtaWHcfqoZcGKXJz-JocED26zBj9n+-ZbQ@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Apr 2018 09:02:03 -0700, Sam Hansen wrote:
> On Fri, Apr 13, 2018 at 5:13 AM, Jean Delvare <jdelvare@suse.de> wrote:
> > On Fri, 13 Apr 2018 00:24:57 +0200, Wolfram Sang wrote:  
> >> On Thu, Apr 12, 2018 at 02:33:42PM -0700, Sam Hansen wrote:  
> >> > -  Not meant to be called  directly; instead, use the access functions
> >> > -  below.
> >> > +  If possible, use the provided i2c_smbus_* methods described below in favor
> >> > +  of issuing direct ioctls.  
> >>
> >> Why this change?  
> >
> > I'm also not sure if "in favor of" is right. "instead of" would sound
> > better to me, but I'm no native English speaker, I could be wrong.  
> 
> Sounds good, I'll adopt "instead of".  Regarding Wolfram's earlier
> comment, as an engineer, requiring an out-of-tree library to build
> drivers felt a little off.  I can revert this section if you want,
> just let me know.

The i2c dev interface, and the overlaying library, are used by
user-space applications. This has nothing to do with "building
drivers", and makes your "out-of-tree" objection irrelevant. I doubt
libi2c is the only user-space library building on top of a kernel
interface.

-- 
Jean Delvare
SUSE L3 Support
