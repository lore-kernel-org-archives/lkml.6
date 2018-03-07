Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933982AbeCGQfP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:35:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33956 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933487AbeCGQfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:35:11 -0500
Subject: Re: [PATCH 1/3 RESEND] tpm: add longer timeouts for creation
 commands.
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Wed, 07 Mar 2018 11:35:03 -0500
In-Reply-To: <20180307085454.2c820a13@lwn.net>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
         <20180305125642.GA3425@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9422E21E@hasmsx108.ger.corp.intel.com>
         <20180306074932.GB3624@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9422EFFE@hasmsx108.ger.corp.intel.com>
         <1520353933.5393.21.camel@HansenPartnership.com>
         <1520361396.10396.396.camel@linux.vnet.ibm.com>
         <20180307085454.2c820a13@lwn.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18030716-0008-0000-0000-000004D8FDAE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030716-0009-0000-0000-00001E6C19F9
Message-Id: <1520440503.10396.534.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803070190
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-07 at 08:54 -0700, Jonathan Corbet wrote:
> On Tue, 06 Mar 2018 13:36:36 -0500
> Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> 
> > I've heard that some maintainers are moving away from cover letters,
> > since they are not include in the git repo and are lost.
> 
> If I get a patch series with a cover letter that should be preserved, I
> apply the series in a branch then do a no-ff merge; the cover letter can
> then go into the merge commit.  There's no reason why cover letters need to
> be lost.

Thanks, Jon.  That sounds like a really, good idea.

Some maintainers are saying to put the Changelog after the "---" so
that it isn't included in the patch description.

One of the reasons for including the Changelog in the patch
description, is to credit people with bug fixes, important rework of
the patch, etc.

Do you have any thoughts on this?

Mimi
