Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752391AbeDINS3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 09:18:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53512 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751550AbeDINS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 09:18:28 -0400
Date: Mon, 9 Apr 2018 15:18:21 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [GIT PULL] s390 patches for the 4.17 merge window #1
In-Reply-To: <20180403111242.49f43ee7@mschwideX1>
References: <20180403111242.49f43ee7@mschwideX1>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18040913-0020-0000-0000-0000040FB6C8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040913-0021-0000-0000-000042A3D7BB
Message-Id: <20180409151821.2d92303f@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804090141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, 3 Apr 2018 11:12:42 +0200
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> please pull from the 'for-linus' branch of
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus
> 
> to receive the following updates:
> 
>  * Improvements for the spectre defense:
>    - The spectre related code is consolidated to a single file nospec-branch.c
>    - Automatic enable/disable for the spectre v2 defenses (expoline vs. nobp)
>    - Syslog messages for specve v2 are added
>    - Enable CONFIG_GENERIC_CPU_VULNERABILITIES and define the attribute
>      functions for spectre v1 and v2
> 
>  * Add helper macros for assembler alternatives and use them to shorten
>    the code in entry.S.
> 
>  * Add support for persistent configuration data via the SCLP Store Data
>    interface. The H/W interface requires a page table that uses 4K pages
>    only, the code to setup such an address space is added as well.
> 
>  * Enable virtio GPU emulation in QEMU. To do this the depends statements
>    for a few common Kconfig options are modified.
> 
>  * Add support for format-3 channel path descriptors and add a binary
>    sysfs interface to export the associated utility strings.
> 
>  * Add a sysfs attribute to control the IFCC handling in case of constant
>    channel errors.
> 
>  * The vfio-ccw changes from Cornelia.
> 
>  * Bug fixes and cleanups.
> 
> There is a trivial merge conflict in drivers/video/console/Kconfig.

Ping.

Did this please-pull get lost or is there a deeper reason that prevents
the upstream integration?

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
