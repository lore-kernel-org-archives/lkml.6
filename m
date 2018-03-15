Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeCOCcQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 22:32:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52940 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751957AbeCOCcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 22:32:14 -0400
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] SCSI fixes for 4.16-rc5
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1521070116.4508.94.camel@HansenPartnership.com>
        <CA+55aFzRss7BfRbLW8fsO5mRhj5obX9sg2ebkNSp5G68VmpWvg@mail.gmail.com>
Date: Wed, 14 Mar 2018 22:32:06 -0400
In-Reply-To: <CA+55aFzRss7BfRbLW8fsO5mRhj5obX9sg2ebkNSp5G68VmpWvg@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 14 Mar 2018 17:09:14 -0700")
Message-ID: <yq1605yax21.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8832 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803150026
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

> I've pulled it, but I don't see why (and how) this kind of garbage got
> reviewed and acked by multiple people.

My bad. I actually did notice the superfluous ifs and meant to nuke them
when I committed the patch.

However, I had a freak accident with my fixes branch that day that
compelled me to reset to my latest public hash and redo several
commits. I completely forgot that I had intended to tweak this patch
when I finally got around to applying it. I should have looked closer,
but it was already in my "done" pile.

Botched it. Sorry about that!

-- 
Martin K. Petersen	Oracle Linux Engineering
