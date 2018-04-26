Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756916AbeDZRYk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 13:24:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753282AbeDZRYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 13:24:35 -0400
From: Jeff Moyer <jmoyer@redhat.com>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        KVM list <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>,
        linux-nvdimm <linux-nvdimm@ml01.01.org>,
        Ross Zwisler <ross.zwisler@intel.com>,
        Qemu Developers <qemu-devel@nongnu.org>, lcapitulino@redhat.com,
        Linux MM <linux-mm@kvack.org>, niteshnarayanlal@hotmail.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        Nitesh Narayan Lal <nilal@redhat.com>,
        Haozhong Zhang <haozhong.zhang@intel.com>,
        Rik van Riel <riel@surriel.com>, Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Igor Mammedov <imammedo@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 1/2] virtio: add pmem driver
References: <20180425112415.12327-1-pagupta@redhat.com>
        <20180425112415.12327-2-pagupta@redhat.com>
        <CAPcyv4hvrB08XPTbVK0xT2_1Xmaid=-v3OMxJVDTNwQucsOHLA@mail.gmail.com>
        <CAPcyv4hiowWozV527sQA_e4fdgCYbD6xfG==vepAqu0hxQEQcw@mail.gmail.com>
        <x49o9i6885e.fsf@segfault.boston.devel.redhat.com>
        <1499190564.23017177.1524762938762.JavaMail.zimbra@redhat.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Date: Thu, 26 Apr 2018 13:24:17 -0400
In-Reply-To: <1499190564.23017177.1524762938762.JavaMail.zimbra@redhat.com>
        (Pankaj Gupta's message of "Thu, 26 Apr 2018 13:15:38 -0400 (EDT)")
Message-ID: <x49in8d6fum.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pankaj Gupta <pagupta@redhat.com> writes:

>> Ideally, qemu (seabios?) would advertise a platform capabilities
>> sub-table that doesn't fill in the flush bits.
>
> Could you please elaborate on this, how its related to disabling
> MAP_SYNC? We are not doing entire nvdimm device emulation. 

My mistake.  If you're not providing an NFIT, then you can ignore this
comment.  I'll have a closer look at your patches next week.

-Jeff
