Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbeCWJl1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:41:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751675AbeCWJlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:41:25 -0400
Date: Fri, 23 Mar 2018 10:41:16 +0100
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
        Vivek Goyal <vgoyal@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 00/11] kexec_file: Clean up purgatory load
In-Reply-To: <20180321160042.0f7d1fe21937f37af96a982a@linux-foundation.org>
References: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
        <20180321160042.0f7d1fe21937f37af96a982a@linux-foundation.org>
Organization: IBM
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18032309-0008-0000-0000-000004E181C9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032309-0009-0000-0000-00001E74AD3F
Message-Id: <20180323104116.0a3f00f4@ThinkPad>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-23_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803230111
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
Hi Dave,

i checked out linux-next with the patches and it looks good to me. Also made a
quick test and everything works fine.

Thanks very much to both of you
Philipp


On Wed, 21 Mar 2018 16:00:42 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 21 Mar 2018 12:27:40 +0100 Philipp Rudo <prudo@linux.vnet.ibm.com> wrote:
> 
> > here is the updated patch set including Dave's comments.  
> 
> There were some syntactic clashes with the "kexec_file, x86, powerpc:
> refactoring for other architecutres" series.  Please check (in
> linux-next) that I got it all correct and that both patch series are
> functioning correctly.
> 
> I expect to send all this into Stephen for -next tomorrow.
> 
