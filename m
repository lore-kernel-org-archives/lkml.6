Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40188C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D240E20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R5wMBYjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D240E20BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeHWLMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:12:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33782 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbeHWLMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:12:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7N7iMa2083974;
        Thu, 23 Aug 2018 07:44:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=OISkejdCnUQ7n1u+9AO5cwXNSfG1nz9xfUQ6TViyWls=;
 b=R5wMBYjmi6gHlGrV78y1/CdrUSiNnqroelkeS59nlIM9yWBX1X82Z/P3IexG9tfa9smR
 6fu7tUGMXEO/3ZYjgqcivjgiEz6YI/BsOuHDfHdNmNgWEkn8AZ5P93u0B14ak9ppX+Lv
 0I3wY7vhXDUI6vHI8cZCm31/Uouvnf9uHGoPnwrD1W0+dRwBBk7MaGCyXq7H48KCUHwA
 KTNdQ6Y1HjE6iPKXqlelq1KujXb+V4toKxMFEt2ggFKZiY74mYAY5gbY1PLsZ8wXCXeX
 +4kwzVaiUTncBUUqkZTNw7p4fVLYmqE8hku6pewHXd7fVpI0TFJDrNBGn1SgD0krmOuI IA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2kxbdq7x68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Aug 2018 07:44:22 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7N7iLu9014693
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Aug 2018 07:44:21 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7N7iLrJ006074;
        Thu, 23 Aug 2018 07:44:21 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Aug 2018 07:44:20 +0000
Date:   Thu, 23 Aug 2018 10:44:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 00/17] staging:rtl8192u: Coding Style changes
Message-ID: <20180823074413.ki7kgebvkshre5ed@mwanda>
References: <20180821171537.9330-1-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821171537.9330-1-johnfwhitmore@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8993 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=591
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808230082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.  Thanks!

regards,
dan carpenter

