Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753478AbeDIQWn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 12:22:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753106AbeDIQWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 12:22:41 -0400
Date: Mon, 9 Apr 2018 18:22:33 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [GIT PULL] s390 patches for the 4.17 merge window #1
In-Reply-To: <CAADWXX-188FC4aBjYMaRwrhcUNvoazwZSirPX3Y2P8PuFiV0bQ@mail.gmail.com>
References: <20180403111242.49f43ee7@mschwideX1>
        <20180409151821.2d92303f@mschwideX1>
        <CAADWXX-188FC4aBjYMaRwrhcUNvoazwZSirPX3Y2P8PuFiV0bQ@mail.gmail.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18040916-0020-0000-0000-0000040FCA95
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040916-0021-0000-0000-000042A3EC1C
Message-Id: <20180409182233.5a9150c5@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-09_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804090169
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Apr 2018 09:07:12 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Apr 9, 2018 at 6:18 AM, Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
> > Hi Linus,
> >
> > On Tue, 3 Apr 2018 11:12:42 +0200
> > Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> >  
> >> please pull from the 'for-linus' branch of
> >>
> >>       git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus
> >>
> >> to receive the following updates:  
> >
> > Ping.
> >
> > Did this please-pull get lost or is there a deeper reason that prevents
> > the upstream integration?  
> 
> I'm not finding the original at all, and this 'ping' message I found
> in my spam-box. Maybe the original was marked as spam too and I didn't
> notice, and it got deleted with the other spam.

Not good, any idea why the ping message has been marked as spam?
Maybe there is something in the headers that gives a hint.
 
> Anyway, pulled now (even if this ping didn't have the diffstat and
> shortlog to check against - everything looks sane)

Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
