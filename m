Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeFEPgN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:36:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751599AbeFEPgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:36:11 -0400
Date: Tue, 5 Jun 2018 17:36:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 2/2] vfio-ccw: support for halt/clear subchannel
Message-ID: <20180605173607.4074f54d.cohuck@redhat.com>
In-Reply-To: <e73038ff-fb2d-5865-8b84-e775990f3983@linux.ibm.com>
References: <20180509154822.23510-1-cohuck@redhat.com>
        <20180509154822.23510-3-cohuck@redhat.com>
        <c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
        <20180515181006.0cb1dfc2.cohuck@redhat.com>
        <a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
        <20180522145208.310143ea.cohuck@redhat.com>
        <4e4001cc-540e-0f2b-bbd1-1f82ca594bb3@linux.ibm.com>
        <20180605151449.22aafbfc.cohuck@redhat.com>
        <e73038ff-fb2d-5865-8b84-e775990f3983@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jun 2018 17:23:02 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

<snip lots of comments - I still need to think about this>

> May be I should try to integrate your patches so we have a better view.

Not sure whether it is worth trying to do so in the current state.
(Also, I really need to get the information into my personal cache
again, before I write too many weird things.)
