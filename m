Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403BCC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F112720866
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F112720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeKBBtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:49:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726375AbeKBBtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:49:36 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA1GivwD127257
        for <linux-kernel@vger.kernel.org>; Thu, 1 Nov 2018 12:45:51 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ng49y2sq1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 12:45:50 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 1 Nov 2018 16:45:49 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 1 Nov 2018 16:45:45 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA1GjiUC29753524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Nov 2018 16:45:45 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD991B2065;
        Thu,  1 Nov 2018 16:45:44 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACBAFB2066;
        Thu,  1 Nov 2018 16:45:44 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.141])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Nov 2018 16:45:44 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0049416C35A8; Thu,  1 Nov 2018 09:45:44 -0700 (PDT)
Date:   Thu, 1 Nov 2018 09:45:44 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     NeilBrown <neil@brown.name>, Mishi Choudhary <mishi@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of
 Conduct: Fix some wording, and add an interpretation document
Reply-To: paulmck@linux.ibm.com
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
 <20181021222608.GA24845@localhost>
 <875zxt919d.fsf@notabene.neil.brown.name>
 <20181024121622.GA10942@localhost>
 <87ftwt6850.fsf@notabene.neil.brown.name>
 <20181027011010.GA29769@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181027011010.GA29769@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18110116-0040-0000-0000-0000048AD30E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009966; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01111172; UDB=6.00575820; IPR=6.00891264;
 MB=3.00023993; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-01 16:45:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110116-0041-0000-0000-00000893D3BC
Message-Id: <20181101164544.GA31540@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-01_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811010142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 02:10:10AM +0100, Josh Triplett wrote:
> On Fri, Oct 26, 2018 at 08:14:51AM +1100, NeilBrown wrote:
> > On Wed, Oct 24 2018, Josh Triplett wrote:
> > 
> > > On Tue, Oct 23, 2018 at 07:26:06AM +1100, NeilBrown wrote:
> > >> On Sun, Oct 21 2018, Josh Triplett wrote:
> > >> 
> > >> > On Mon, Oct 22, 2018 at 08:20:11AM +1100, NeilBrown wrote:
> > >> >> I call on you, Greg:
> > >> >>  - to abandon this divisive attempt to impose a "Code of Conduct"
> > >> >>  - to revert 8a104f8b5867c68
> > >> >>  - to return to your core competence of building a great team around
> > >> >>    a great kernel
> > >> >> 
> > >> >>  #Isupportreversion
> > >> >> 
> > >> >> I call on the community to consider what *does* need to be said, about
> > >> >> conduct, to people outside the community and who have recently joined.
> > >> >> What is the document that you would have liked to have read as you were
> > >> >> starting out?  It is all too long ago for me to remember clearly, and so
> > >> >> much has changed.
> > >> >
> > >> > The document I would have liked to have read when starting out is
> > >> > currently checked into the source tree in
> > >> > Documentation/process/code-of-conduct.rst .
> > >> 
> > >> I'm curious - what would you have gained by reading that document?
> > >
> > > I would have then had rather less of a pervasive feeling of "if I make
> > > even a single mistake I get made an example of in ways that will feed
> > > people's quotes files for years to come".
> > 
> > Thanks for your reply.  Certainly feeling safe is important, and having
> > clear statements that the community values and promotes psychological
> > safety is valuable.
> > 
> > The old "code of conflict" said
> >    If however, anyone feels personally abused, threatened, or otherwise
> >    uncomfortable due to this process, that is not acceptable. 
> > 
> > would you have not found this a strong enough statement to ward off that
> > pervasive feeling?
> 
> Not when that document started out effectively saying, in an elaborate
> way, "code > people".

Interesting.

I am curious what leads you to your "code > people" statement.  Of course,
one could argue that this does not really matter given that the code of
conflict is no longer.  However, I would like to understand for future
reference, if for no other reason.

One possibility is that you are restricting the "people" to only those
people directly contributing in one way or another.  But those using the
kernel (both directly and indirectly) are important as well, and it is
exactly this group that is served by "the most robust operating system
kernel ever", the chest-beating sentiment notwithstanding.  Which is in
fact why I must reject (or rework or whatever) any patch that might result
in too-short RCU grace periods:  The needs of the patch's submitter are
quite emphatically outweighed by the needs of the kernel's many users,
and many of the various technical requirements and restrictions are in
fact proxies for the needs of these users.

But you knew that already.

Similarly for the Linux kernel's various code-style strictures, which
serve the surprisingly large group of people reading the kernel's code.
Including the stricture that I most love to hate, which is the one
stating that single-line do/for/if/while statements must not be enclosed
in braces, which sometimes causes me trouble when inserting debug code,
but which also makes more code fit into a window of a given size.  ;-)

But you knew that already, too.

The maintainability requirements can be argued to mostly serve the
maintainers, but if the code becomes unmaintainable, future users
will be inconvenienced, to say the least.  So even the maintainability
requirements serve the kernel's many users.

But you also knew that already.

So what am I missing here?

							Thanx, Paul

>                       (Leaving aside that the more important detail
> would be the community actually acting consistently with the code of
> conduct it espoused.)
> 
> > In the current code, would The "Our Pledge" section have been
> > sufficient, or do you think the other sections would have actually
> > helped you?
> 
> "Our Standards" would have been at least as important to me personally,
> as would "Enforcement" (and more importantly, examples of that applying
> in practice and not just as empty words).
> _______________________________________________
> Ksummit-discuss mailing list
> Ksummit-discuss@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
> 

