Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030790AbeE2BVh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 21:21:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43690 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965355AbeE2BVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 21:21:34 -0400
To: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Laurence Oberman <loberman@redhat.com>,
        Ewan Milne <emilne@redhat.com>, James Smart <james.smart@broadcom.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Martin George <marting@netapp.com>,
        John Meneghini <John.Meneghini@netapp.com>
Subject: Re: [PATCH 0/3] Provide more fine grained control over multipathing
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180525125322.15398-1-jthumshirn@suse.de>
        <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com>
        <20180525141211.GA25971@lst.de> <20180525145056.GD9591@redhat.com>
Date: Mon, 28 May 2018 21:19:43 -0400
In-Reply-To: <20180525145056.GD9591@redhat.com> (Mike Snitzer's message of
        "Fri, 25 May 2018 10:50:56 -0400")
Message-ID: <yq1muwj45sg.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8907 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=753
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805290013
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mike,

I understand and appreciate your position but I still don't think the
arguments for enabling DM multipath are sufficiently compelling. The
whole point of ANA is for things to be plug and play without any admin
intervention whatsoever.

I also think we're getting ahead of ourselves a bit. The assumption
seems to be that NVMe ANA devices are going to be broken--or that they
will require the same amount of tweaking as SCSI devices--and therefore
DM multipath support is inevitable. However, I'm not sure that will be
the case.

> Thing is you really don't get to dictate that to the industry.  Sorry.

We are in the fortunate position of being able to influence how the spec
is written. It's a great opportunity to fix the mistakes of the past in
SCSI. And to encourage the industry to ship products that don't need the
current level of manual configuration and complex management.

So I am in favor of Johannes' patches *if* we get to the point where a
Plan B is needed. But I am not entirely convinced that's the case just
yet. Let's see some more ANA devices first. And once we do, we are also
in a position where we can put some pressure on the vendors to either
amend the specification or fix their implementations to work with ANA.

-- 
Martin K. Petersen	Oracle Linux Engineering
