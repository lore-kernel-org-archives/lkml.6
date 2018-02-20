Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbeBTUzT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 15:55:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60766 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751265AbeBTUzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 15:55:18 -0500
Subject: Re: linux-next: Signed-off-by missing for commits in the kvms390 tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Cornelia Huck <cohuck@redhat.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180221074734.6cd689ec@canb.auug.org.au>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 20 Feb 2018 21:55:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221074734.6cd689ec@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18022020-0008-0000-0000-000004D26BC6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022020-0009-0000-0000-00001E6570B9
Message-Id: <eb1c9f26-b6ea-56ae-826f-dafd1de3bb45@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-20_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802200252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed. thanks a lot.

On 02/20/2018 09:51 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   6558ff10e614 ("Kconfig : Remove HAS_IOMEM dependency for Graphics support")
>   60da5bfd79f7 ("s390/char : Rename EBCDIC keymap variables")
>   74113cf840c7 ("s390/setup : enable display support for KVM guest")
> 
> are missing a Signed-off-by from their committer.
> 
