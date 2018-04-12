Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753668AbeDLTzZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 15:55:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752831AbeDLTzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 15:55:24 -0400
Subject: Re: [PATCH 1/2] perf tools powerpc: Fix callchain ip filtering
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: jolsa@redhat.com, linux-kernel@vger.kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, ravi.bangoria@linux.vnet.ibm.com,
        Maynard Johnson <maynard@us.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
References: <20180412171129.4422-1-sandipan@linux.vnet.ibm.com>
 <20180412171129.4422-2-sandipan@linux.vnet.ibm.com>
 <20180412184316.GA10387@kernel.org>
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
Date: Fri, 13 Apr 2018 01:25:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180412184316.GA10387@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041219-0008-0000-0000-000004E9E6B0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041219-0009-0000-0000-00001E7DF156
Message-Id: <e541e895-524d-aff1-136e-fab08a23c137@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-12_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804120190
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/13/2018 12:13 AM, Arnaldo Carvalho de Melo wrote:
> 
> So, the author for the fixed-by patch here is Sukadev Bhattiprolu
> <sukadev@linux.vnet.ibm.com>, and the reporter for the problem that
> patch fixed is Maynard Johnson <maynard@us.ibm.com>, who also tested
> that patch, I think it'd be better if they get CCed to have the
> opportunity to ack/comment, but since everybody is at IBM, perhaps
> those guys are not anymore involved with ppc at IBM?
> 
> I'm CCing anyway :-)
> 
> - Arnaldo
> 

Sorry I missed that. Thanks for adding them :-)

- Sandipan
