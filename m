Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753095AbeCMSCO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 14:02:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753069AbeCMSCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 14:02:11 -0400
Subject: Re: [RFC PATCH 1/5] ima: extend clone() with IMA namespace support
To: James Morris <jmorris@namei.org>
References: <20170720225033.21298-1-mkayaalp@linux.vnet.ibm.com>
 <20170720225033.21298-2-mkayaalp@linux.vnet.ibm.com>
 <20170725175317.GA727@mail.hallyn.com>
 <1501008554.3689.30.camel@HansenPartnership.com>
 <20170725190406.GA1883@mail.hallyn.com>
 <1501009739.3689.33.camel@HansenPartnership.com>
 <1501012082.27413.17.camel@linux.vnet.ibm.com>
 <645db815-7773-e351-5db7-89f38cd88c3d@linux.vnet.ibm.com>
 <20170725204622.GA4969@mail.hallyn.com>
 <97839865-b0ab-8e5d-114e-0603ef2edf6f@linux.vnet.ibm.com>
 <20180309025942.GA15295@mail.hallyn.com>
 <ec137677-34f8-df91-0d1c-6c6d6c951496@linux.vnet.ibm.com>
 <alpine.LRH.2.21.1803120953310.26512@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
        Mehmet Kayaalp <mkayaalp@cs.binghamton.edu>,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>,
        Yuqiong Sun <sunyuqiong1988@gmail.com>,
        containers <containers@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Safford <david.safford@ge.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        ima-devel <linux-ima-devel@lists.sourceforge.net>,
        Yuqiong Sun <suny@us.ibm.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 13 Mar 2018 14:02:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1803120953310.26512@namei.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18031318-0008-0000-0000-00000973D5A0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008667; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01002542; UDB=6.00510135; IPR=6.00781872;
 MB=3.00020011; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-13 18:02:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031318-0009-0000-0000-00004660553C
Message-Id: <c39350db-046f-ea70-15e4-210884548b1e@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803130203
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2018 06:58 PM, James Morris wrote:
> On Fri, 9 Mar 2018, Stefan Berger wrote:
>
>> Yuqiong is publishing a paper in this area. I believe the conference is only
>> later this year.
>>
>> Our goals are to enable IMA measurements, appraisal, and auditing inside a
>> container using namespaces.
> This is excellent to have -- can you include this requirements analysis as
> a file Documentation/security on the next posting?
>
> Also, if you need a public space for managing these kinds of documents,
> consider utilizing
> http://kernsec.org/wiki/index.php/Linux_Kernel_Integrity

Thanks for the pointer. I tried creating an account, but the interface 
wouldn't let me. Who is managing it?

    Stefan

>
>
> - James
