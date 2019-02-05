Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48F8C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 03:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E94A2081B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 03:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ljLeHyFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfBEDiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 22:38:04 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39392 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfBEDiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 22:38:03 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x153YUsR082183;
        Tue, 5 Feb 2019 03:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=ItyfEhdbeehWxRmgNWxMfsJSuxXS08cwgMlHbTqKva4=;
 b=ljLeHyFV+RU28wV2zRMOH0iouWl1MwklINXEi/6GU1L9vuB1gyjKMPMqvye3Eq+5UtqP
 8YXE5IfLubElCazGieUhEtRSCPqAJE4izx7FR0EhEUDVwwUCt6OO2DFKldoRlAfSvRSA
 TxQrdW6PmWMJgQHwYWIk78u+6f1Ftbi7qqlf6mgav9ptRDmJniv0kwz7JGwBH7PrnL5/
 GwgFtcbF6iFrtAhy80ObY7Ehg+tDPXPKSkBr5H4sg4LhiyX7cbwauovdW/pquyao9zQ1
 eDVjokRnA19Mhe9ct3gfMyKVrBtaGqpAvrushd7T6caDNpyX4aTvd8juAnTOjF05Ybsj pA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2qd9ar8pnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Feb 2019 03:37:59 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x153bwsX031657
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Feb 2019 03:37:58 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x153bvwV005106;
        Tue, 5 Feb 2019 03:37:57 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Feb 2019 03:37:57 +0000
To:     Joao Pinto <joao.pinto@synopsys.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        pedrom.sousa@synopsys.com, marc.w.gonzalez@free.fr,
        Alex.Lemberg@wdc.com
Subject: Re: [PATCH for-next] scsi: ufs: Update dwc driver maintainer to Pedro Sousa
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <812e9e1426555808ad1bd5fbfda320c6684abc81.1548869844.git.jpinto@synopsys.com>
Date:   Mon, 04 Feb 2019 22:37:54 -0500
In-Reply-To: <812e9e1426555808ad1bd5fbfda320c6684abc81.1548869844.git.jpinto@synopsys.com>
        (Joao Pinto's message of "Wed, 30 Jan 2019 18:48:13 +0100")
Message-ID: <yq1a7ja3nxp.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9157 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=717 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902050026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Joao,

> Currently I am managing the Synopsys drivers & tools team (full-time) and
> so I am passing the DWC UFS driver maintenance to Pedro Sousa.

Applied to 5.1/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
