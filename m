Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752686AbeDTUm3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 16:42:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49866 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751860AbeDTUm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 16:42:28 -0400
Date: Fri, 20 Apr 2018 13:43:34 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: ensure whatisRCU.txt actually says what RCU is.
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180419175936.19936-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419175936.19936-1-paul.gortmaker@windriver.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18042020-0044-0000-0000-000004089E3E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008889; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01020811; UDB=6.00520896; IPR=6.00800048;
 MB=3.00020689; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-20 20:42:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042020-0045-0000-0000-0000083AA589
Message-Id: <20180420204334.GS26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804200208
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 01:59:36PM -0400, Paul Gortmaker wrote:
> It came to my attention that the file "whatisRCU.txt" does not
> manage to actually ever spell out what is RCU.
> 
> This might not be an issue for a lot of people, but we have to
> assume the consumers of these documents are starting from ground
> zero; otherwise they'd not be reading the docs.
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Queued for review, thank you!

							Thanx, Paul

> ---
>  Documentation/RCU/whatisRCU.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.txt
> index a27fbfb0efb8..65eb856526b7 100644
> --- a/Documentation/RCU/whatisRCU.txt
> +++ b/Documentation/RCU/whatisRCU.txt
> @@ -1,3 +1,5 @@
> +What is RCU?  --  "Read, Copy, Update"
> +
>  Please note that the "What is RCU?" LWN series is an excellent place
>  to start learning about RCU:
> 
> -- 
> 2.14.1
> 
