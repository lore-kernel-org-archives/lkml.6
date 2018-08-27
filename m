Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A15C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD9E20BED
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD9E20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeH1Af2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 20:35:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35906 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726994AbeH1Af1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 20:35:27 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7RKhXCc132730
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:47:12 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m4m6gtsxw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:47:12 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Mon, 27 Aug 2018 14:47:11 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 27 Aug 2018 14:47:09 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7RKl8JQ42532914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Aug 2018 13:47:08 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E60D78064;
        Mon, 27 Aug 2018 14:47:08 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23EA878067;
        Mon, 27 Aug 2018 14:47:07 -0600 (MDT)
Received: from morokweng.localdomain (unknown [9.85.152.225])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Mon, 27 Aug 2018 14:47:06 -0600 (MDT)
References: <20180725025725.4214-1-bauerman@linux.ibm.com> <99fd20f8-b3fd-c5b7-ccb2-092888c8545f@kernel.org>
User-agent: mu4e 1.0; emacs 25.3.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: kselftest: Remove outdated comment
In-reply-to: <99fd20f8-b3fd-c5b7-ccb2-092888c8545f@kernel.org>
Date:   Mon, 27 Aug 2018 17:47:03 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18082720-8235-0000-0000-00000DF35117
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009622; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01079749; UDB=6.00556899; IPR=6.00859732;
 MB=3.00022963; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-27 20:47:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082720-8236-0000-0000-0000426D884A
Message-Id: <871sajtu48.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-27_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808270213
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Shuah Khan <shuah@kernel.org> writes:

> On 07/24/2018 08:57 PM, Thiago Jung Bauermann wrote:
>> Commit 3c07aaef6598 ("selftests: kselftest: change KSFT_SKIP=4 instead of
>> KSFT_PASS") reverted commit 11867a77eb85 ("selftests: kselftest framework:
>> change skip exit code to 0") but missed removing the comment which that
>> commit added, so do that now.
>> 
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> ---
>>  tools/testing/selftests/kselftest.h | 1 -
>>  1 file changed, 1 deletion(-)
>> 
>> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
>> index 15e6b75fc3a5..a3edb2c8e43d 100644
>> --- a/tools/testing/selftests/kselftest.h
>> +++ b/tools/testing/selftests/kselftest.h
>> @@ -19,7 +19,6 @@
>>  #define KSFT_FAIL  1
>>  #define KSFT_XFAIL 2
>>  #define KSFT_XPASS 3
>> -/* Treat skip as pass */
>>  #define KSFT_SKIP  4
>>  
>>  /* counters */
>> 
>> 
>
> Thanks for the patch. Sorry for the delay. It is now in linux-kselfttest
> next for the next 4.19-rc

The delay isn't a problem. Thanks!

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

