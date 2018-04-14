Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751292AbeDNPeY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 11:34:24 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:41542 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751137AbeDNPeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 11:34:23 -0400
X-Google-Smtp-Source: AIpwx499x8RT3YPjwoSuSMTMg9/0rLj83k526F1nJOwhKgBBAEB1vTiHldCL2uoN6l3uFVeMNUmxfwZOEYsvlBm9O/4=
MIME-Version: 1.0
References: <9ad4563e701a38915d58552f9eee5b3602833ddf.camel@wdc.com>
 <20180413172708.30286-1-gthelen@google.com> <b1f20a68-2ed4-935f-4a9c-8a28c142ceee@intel.com>
In-Reply-To: <b1f20a68-2ed4-935f-4a9c-8a28c142ceee@intel.com>
From: Greg Thelen <gthelen@google.com>
Date: Sat, 14 Apr 2018 15:34:10 +0000
Message-ID: <CAHH2K0YTCa99ZfCdvq0WEJVvszo7+kUiVP_cz0igqE4TZSNYGQ@mail.gmail.com>
Subject: Re: [PATCH v2] IB: make INFINIBAND_ADDR_TRANS configurable
To: dennis.dalessandro@intel.com
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Tarick Bedeir <tarick@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 14, 2018 at 8:13 AM Dennis Dalessandro <
dennis.dalessandro@intel.com> wrote:

> On 4/13/2018 1:27 PM, Greg Thelen wrote:
> > Allow INFINIBAND without INFINIBAND_ADDR_TRANS.
> >
> > Signed-off-by: Greg Thelen <gthelen@google.com>
> > Cc: Tarick Bedeir <tarick@google.com>
> > Change-Id: I6fbbf8a432e467710fa65e4904b7d61880b914e5

> Forgot to remove the Gerrit thing.

> -Denny

Ack.  My bad.  Will repost.  Unfortunately checkpatch didn't notice.
