Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE911C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 19:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E04F21871
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 19:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbeLaTnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 14:43:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727405AbeLaTnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 14:43:23 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBVJXXoc110491
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 14:43:21 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pqkpfmgc9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 14:43:21 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 31 Dec 2018 19:43:20 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 31 Dec 2018 19:43:17 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBVJhGNL22216802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Dec 2018 19:43:16 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B100B2064;
        Mon, 31 Dec 2018 19:43:16 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAB40B205F;
        Mon, 31 Dec 2018 19:43:15 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.153.1])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 31 Dec 2018 19:43:15 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 621A216C32AD; Mon, 31 Dec 2018 11:43:32 -0800 (PST)
Date:   Mon, 31 Dec 2018 11:43:32 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joey Pabalinas <joeypabalinas@gmail.com>, Willy Tarreau <w@1wt.eu>,
        mingo@kernel.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] rcutorture/nolibc: fix some poor indentation and
 alignment
Reply-To: paulmck@linux.ibm.com
References: <20181229180218.15798-1-w@1wt.eu>
 <20181229180218.15798-3-w@1wt.eu>
 <20181229223033.q4gx4cn7ci6scysr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181229223033.q4gx4cn7ci6scysr@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18123119-0052-0000-0000-0000036FED48
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010323; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000272; SDB=6.01139844; UDB=6.00593097; IPR=6.00920054;
 MB=3.00024915; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-31 19:43:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18123119-0053-0000-0000-00005F4AE67E
Message-Id: <20181231194332.GR4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-31_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812310171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 12:30:33PM -1000, Joey Pabalinas wrote:
> On Sat, Dec 29, 2018 at 07:02:17PM +0100, Willy Tarreau wrote:
> > A few macros had their rightmost backslash misaligned, and the pollfd
> > struct definition resisted the previous code reindent. Nothing else
> > changed.
> > 
> > Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Signed-off-by: Willy Tarreau <w@1wt.eu>
> 
> Reviewed-by: Joey Pabalinas <joeypabalinas@gmail.com>

Applied, thank you both!

							Thanx, Paul

> > ---
> >  tools/testing/selftests/rcutorture/bin/nolibc.h | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/rcutorture/bin/nolibc.h b/tools/testing/selftests/rcutorture/bin/nolibc.h
> > index 30bd27b..985364c 100644
> > --- a/tools/testing/selftests/rcutorture/bin/nolibc.h
> > +++ b/tools/testing/selftests/rcutorture/bin/nolibc.h
> > @@ -81,9 +81,9 @@ typedef   signed long        time_t;
> >  
> >  /* for poll() */
> >  struct pollfd {
> > -    int fd;
> > -    short int events;
> > -    short int revents;
> > +	int fd;
> > +	short int events;
> > +	short int revents;
> >  };
> >  
> >  /* for select() */
> > @@ -239,7 +239,7 @@ struct stat {
> >  		"syscall\n"                                                   \
> >  		: "=a" (_ret)                                                 \
> >  		: "0"(_num)                                                   \
> > -		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"                                \
> > +		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"             \
> >  	);                                                                    \
> >  	_ret;                                                                 \
> >  })
> > @@ -255,7 +255,7 @@ struct stat {
> >  		: "=a" (_ret)                                                 \
> >  		: "r"(_arg1),                                                 \
> >  		  "0"(_num)                                                   \
> > -		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"                                \
> > +		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"             \
> >  	);                                                                    \
> >  	_ret;                                                                 \
> >  })
> > @@ -272,7 +272,7 @@ struct stat {
> >  		: "=a" (_ret)                                                 \
> >  		: "r"(_arg1), "r"(_arg2),                                     \
> >  		  "0"(_num)                                                   \
> > -		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"                                \
> > +		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"             \
> >  	);                                                                    \
> >  	_ret;                                                                 \
> >  })
> > @@ -290,7 +290,7 @@ struct stat {
> >  		: "=a" (_ret)                                                 \
> >  		: "r"(_arg1), "r"(_arg2), "r"(_arg3),                         \
> >  		  "0"(_num)                                                   \
> > -		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"                                \
> > +		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"             \
> >  	);                                                                    \
> >  	_ret;                                                                 \
> >  })
> > -- 
> > 2.9.0
> > 
> 
> -- 
> Cheers,
> Joey Pabalinas


