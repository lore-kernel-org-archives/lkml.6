Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeBCBbo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 20:31:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51920 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751582AbeBCBbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 20:31:36 -0500
Date: Fri, 2 Feb 2018 17:21:03 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: corbet@lwn.net, dhowells@redhat.com, will.deacon@arm.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, stern@rowland.harvard.edu,
        boqun.feng@gmail.com, npiggin@gmail.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr
Subject: Re: [PATCH 1/2] Documentation/memory-barriers.txt: cross-reference
 "tools/memory-model/"
Reply-To: paulmck@linux.vnet.ibm.com
References: <1517562768-6238-1-git-send-email-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517562768-6238-1-git-send-email-parri.andrea@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18020301-0044-0000-0000-000003DAE2F1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008463; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000248; SDB=6.00984193; UDB=6.00499213; IPR=6.00763471;
 BA=6.00005809; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019343; XFM=3.00000015;
 UTC=2018-02-03 01:31:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020301-0045-0000-0000-0000080A4FD3
Message-Id: <20180203012103.GD3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-02_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802030015
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 10:12:48AM +0100, Andrea Parri wrote:
> Recent efforts led to the specification of a memory consistency model
> for the Linux kernel [1], which "can (roughly speaking) be thought of
> as an automated version of memory-barriers.txt" and which is (in turn)
> "accompanied by extensive documentation on its use and its design".
> 
> Make sure that the (occasional) reader of memory-barriers.txt will be
> aware of these developments.
> 
> [1] https://marc.info/?l=linux-kernel&m=151687290114799&w=2
> 
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>

I am inclined to pull in something along these lines, but would like
some feedback on the wording, especially how "official" we want to
make the memory model to be.

Thoughts?

If I don't hear otherwise in a couple of days, I will pull this as is.

							Thanx, Paul

> ---
>  Documentation/memory-barriers.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index a863009849a3b..8cc3f098f4a7d 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -17,7 +17,9 @@ meant as a guide to using the various memory barriers provided by Linux, but
>  in case of any doubt (and there are many) please ask.
> 
>  To repeat, this document is not a specification of what Linux expects from
> -hardware.
> +hardware.  For such a specification, in the form of a memory consistency
> +model, and for documentation about its usage and its design, the reader is
> +referred to "tools/memory-model/".
> 
>  The purpose of this document is twofold:
> 
> -- 
> 2.7.4
> 
