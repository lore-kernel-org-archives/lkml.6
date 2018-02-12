Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934107AbeBLLaA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 06:30:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934072AbeBLL3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 06:29:48 -0500
Date: Mon, 12 Feb 2018 12:29:40 +0100
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
To: Philippe Ombredanne <pombredanne@nexb.com>
Cc: kexec@lists.infradead.org, linux-s390@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Vivek Goyal <vgoyal@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
Subject: Re: [PATCH 14/17] s390/kexec_file: Add kexec_file_load system call
In-Reply-To: <CAOFm3uFfXZZuQ6cM=pi34ybxM37BQVz08ctJmh5LryVGVgEjjA@mail.gmail.com>
References: <20180212100754.55121-1-prudo@linux.vnet.ibm.com>
        <20180212100754.55121-15-prudo@linux.vnet.ibm.com>
        <CAOFm3uFfXZZuQ6cM=pi34ybxM37BQVz08ctJmh5LryVGVgEjjA@mail.gmail.com>
Organization: IBM
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18021211-0008-0000-0000-000004CBDE10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021211-0009-0000-0000-00001E5F9B3B
Message-Id: <20180212122940.2238fdd0@ThinkPad>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802120150
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2018 11:56:25 +0100
Philippe Ombredanne <pombredanne@nexb.com> wrote:

> On Mon, Feb 12, 2018 at 11:07 AM, Philipp Rudo <prudo@linux.vnet.ibm.com> wrote:
> > This patch adds the kexec_file_load system call to s390 as well as the arch
> > specific functions common code requires to work. Loaders for the different
> > file types will be added later.
> >
> > Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>  
> 
> <snip>
> 
> > --- /dev/null
> > +++ b/arch/s390/kernel/machine_kexec_file.c
> > @@ -0,0 +1,174 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */  
> 
> I know this may sound weird but in .c files this should be instead:
> 
> // SPDX-License-Identifier: GPL-2.0
> 
> See Documentation/process/license-rules.rst for why.

Oups, you are right. I fixed it locally for all files.

Thanks for pointing this out
Philipp
