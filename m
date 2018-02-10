Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753377AbeBJAzi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 19:55:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753300AbeBJAzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 19:55:36 -0500
Date: Fri, 9 Feb 2018 16:55:42 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, stern@rowland.harvard.edu,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, corbet@lwn.net
Subject: Re: [PATCH 1/2] Documentation/memory-barriers.txt: cross-reference
 "tools/memory-model/"
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180203012103.GD3617@linux.vnet.ibm.com>
 <8b4db282-2705-ed96-cf23-b0cdf94bbac8@gmail.com>
 <20180204183708.GA10437@andrea>
 <20180209123100.GY3617@linux.vnet.ibm.com>
 <20180209125051.GA21678@andrea>
 <20180209142923.GB3617@linux.vnet.ibm.com>
 <20180209150053.GA24203@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209150053.GA24203@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18021000-0036-0000-0000-000002BC1668
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008506; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000251; SDB=6.00987439; UDB=6.00501210; IPR=6.00766797;
 BA=6.00005821; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019471; XFM=3.00000015;
 UTC=2018-02-10 00:55:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021000-0037-0000-0000-000043492799
Message-Id: <20180210005542.GC3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-09_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802100009
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 04:00:53PM +0100, Andrea Parri wrote:
> On Fri, Feb 09, 2018 at 06:29:23AM -0800, Paul E. McKenney wrote:
> > On Fri, Feb 09, 2018 at 01:50:51PM +0100, Andrea Parri wrote:
> > > On Fri, Feb 09, 2018 at 04:31:00AM -0800, Paul E. McKenney wrote:
> > > > On Sun, Feb 04, 2018 at 07:37:08PM +0100, Andrea Parri wrote:
> > > > > Hi Akira,
> > > > > 
> > > > > On Mon, Feb 05, 2018 at 01:14:10AM +0900, Akira Yokosawa wrote:
> > > > > > Hi Paul,
> > > > > > CC: Andrea
> > > > > > 
> > > > > > This is intentionally off the list, as I was not cc'd in the thread.
> > > > > > If you think it is worthwhile, could you help me join the thread by
> > > > > > forwarding the following part as a reply to your message, plus CC: to me.
> > > > > 
> > > > > [CCing lists and other people]
> > > > > 
> > > > > 
> > > > > > 
> > > > > > On Fri, Feb 02, 2018 at 17:21:03AM -0800, Paul E. McKenney wrote:
> > > > > > > On Fri, Feb 02, 2018 at 10:12:48AM +0100, Andrea Parri wrote:
> > > > > > >> Recent efforts led to the specification of a memory consistency model
> > > > > > >> for the Linux kernel [1], which "can (roughly speaking) be thought of
> > > > > > >> as an automated version of memory-barriers.txt" and which is (in turn)
> > > > > > >> "accompanied by extensive documentation on its use and its design".
> > > > > > >> 
> > > > > > >> Make sure that the (occasional) reader of memory-barriers.txt will be
> > > > > > >> aware of these developments.
> > > > > > >> 
> > > > > > >> [1] https://marc.info/?l=linux-kernel&m=151687290114799&w=2
> > > > > > >> 
> > > > > > >> Signed-off-by: Andrea Parri <parri.andrea@xxxxxxxxx>
> > > > > > > 
> > > > > > > I am inclined to pull in something along these lines, but would like
> > > > > > > some feedback on the wording, especially how "official" we want to
> > > > > > > make the memory model to be.
> > > > > > > 
> > > > > > > Thoughts?
> > > > > > 
> > > > > > The change log of commit e7720af5f9ac ("locking/Documentation: Add disclaimer") says:
> > > > > >     
> > > > > >     It appears people are reading this document as a requirements list for
> > > > > >     building hardware. This is not the intent of this document. Nor is it
> > > > > >     particularly suited for this purpose.
> > > > > >     
> > > > > >     The primary purpose of this document is our collective attempt to define
> > > > > >     a set of primitives that (hopefully) allow us to write correct code on
> > > > > >     the myriad of SMP platforms Linux supports.
> > > > > >     
> > > > > >     Its a definite work in progress as our understanding of these platforms,
> > > > > >     and memory ordering in general, progresses.
> > > > > >     
> > > > > >     Nor does being mentioned in this document mean we think its a
> > > > > >     particularly good idea; the data dependency barrier required by Alpha
> > > > > >     being a prime example. Yes we have it, no you're insane to require it
> > > > > >     when building new hardware.
> > > > > > 
> > > > > > My take on the Linux Kernel memory-consistency model is a supplement of
> > > > > > memory-barriers.txt and the disclaimer also applies to the memory model.
> > > > > > 
> > > > > > > 
> > > > > > > If I don't hear otherwise in a couple of days, I will pull this as is.
> > > > > > > 
> > > > > > > 							Thanx, Paul
> > > > > > > 
> > > > > > >> ---
> > > > > > >>  Documentation/memory-barriers.txt | 4 +++-
> > > > > > >>  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > >> 
> > > > > > >> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> > > > > > >> index a863009849a3b..8cc3f098f4a7d 100644
> > > > > > >> --- a/Documentation/memory-barriers.txt
> > > > > > >> +++ b/Documentation/memory-barriers.txt
> > > > > > >> @@ -17,7 +17,9 @@ meant as a guide to using the various memory barriers provided by Linux, but
> > > > > > >>  in case of any doubt (and there are many) please ask.
> > > > > > >> 
> > > > > > >>  To repeat, this document is not a specification of what Linux expects from
> > > > > > >> -hardware.
> > > > > > >> +hardware.  For such a specification, in the form of a memory consistency
> > > > > > >> +model, and for documentation about its usage and its design, the reader is
> > > > > > >> +referred to "tools/memory-model/".
> > > > > > >> 
> > > > > > 
> > > > > > Adding cross-reference in this way can _weaken_ the message of the disclaimer.
> > > > > 
> > > > > Thank you for your remarks; I do share the same concern.
> > > > > 
> > > > > > What about adding it in the previous sentence as the patch appended bellow?
> > > > > 
> > > > > I do like this idea: I believe that my phrasing (and that "what Linux
> > > > > expects from hardware") may be easily subject to misinterpretation...
> > > > > which your solution can avoid.
> > > > 
> > > > Any objections to Akira's patch below?  (Give or take the usual
> > > > wordsmithing.)
> > > > 
> > > > Andrea, should I interpret your paragraph above ask an Acked-by?
> > > 
> > > Well, I am among the Signed-off-by: of the patch; it didn't seem too fair
> > > to me to Ack my own patch... ;-) Is the wording sound? other suggestions?
> > 
> > Good point, too many all-day meetings last week.  ;-)
> > 
> > How about the following?
> 
> Even better IMO,

Very good, thank you both!

I will include this in the version of the series.

							Thanx, Paul

> Thanks!
> 
>   Andrea
> 
> 
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 9370f98c312d658afe88e548d469549d8f31e402
> > Author: Andrea Parri <parri.andrea@gmail.com>
> > Date:   Fri Feb 9 06:26:08 2018 -0800
> > 
> >     Documentation/memory-barriers.txt: Cross-reference "tools/memory-model/"
> >     
> >     A memory consistency model is now available for the Linux kernel [1],
> >     which "can (roughly speaking) be thought of as an automated version of
> >     memory-barriers.txt" and which is (in turn) "accompanied by extensive
> >     documentation on its use and its design".
> >     
> >     Inform the (occasional) reader of memory-barriers.txt of these
> >     developments.
> >     
> >     [1] https://marc.info/?l=linux-kernel&m=151687290114799&w=2
> >     
> >     Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
> >     Co-developed-by: Akira Yokosawa <akiyks@gmail.com>
> >     Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> >     Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > 
> > diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> > index 479ecec80593..74ad222d11ed 100644
> > --- a/Documentation/memory-barriers.txt
> > +++ b/Documentation/memory-barriers.txt
> > @@ -14,7 +14,11 @@ DISCLAIMER
> >  This document is not a specification; it is intentionally (for the sake of
> >  brevity) and unintentionally (due to being human) incomplete. This document is
> >  meant as a guide to using the various memory barriers provided by Linux, but
> > -in case of any doubt (and there are many) please ask.
> > +in case of any doubt (and there are many) please ask.  Some doubts may be
> > +resolved by referring to the formal memory consistency model and related
> > +documentation at tools/memory-model/.  Nevertheless, even this memory
> > +model should be viewed as the collective opinion of its maintainers rather
> > +than as an infallible oracle.
> >  
> >  To repeat, this document is not a specification of what Linux expects from
> >  hardware.
> > 
> 
