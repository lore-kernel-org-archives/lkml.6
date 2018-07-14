Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94C2ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 04:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B6C208CC
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 04:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LgpiCssw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B6C208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbeGNFO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 01:14:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43018 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725851AbeGNFO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 01:14:56 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6E4tTJn006815
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 21:57:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=xmL8ncCAtnG56m8r5iFvOdITLASi8jNXBkQUtAB/CYI=;
 b=LgpiCsswq34LaF2I1sNYRALu4D4bzNNi6Md4SmloyIC+APaA79qeSy0fR9rbXE7DtpSr
 COgbGPzdRsojygh4Oc5ZfsFzKkUg8U/G5ZNoAE6CqeemBivCL1c+dj7T/jJIPhBB385M
 CWuw/RZfeT8x6GS/j1vyHIW7hVkRj2KV9+8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k7a3qr154-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 21:57:17 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.15) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 13 Jul
 2018 21:57:16 -0700
Received: by dev026.lla1.facebook.com (Postfix, from userid 152872)     id
 27E308A46B4; Fri, 13 Jul 2018 21:57:14 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Okash Khawaja <osk@fb.com>
Smtp-Origin-Hostname: dev026.lla1.facebook.com
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S . Miller" <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>
Smtp-Origin-Cluster: lla1c22
Subject: [PATCH bpf-next v5 0/3] bpf: btf: print bpftool map data with btf
Date:   Fri, 13 Jul 2018 21:57:01 -0700
Message-ID: <20180714045704.3779427-1-osk@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-14_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-sending v5 with updated Reviewed-by and Acked-by.


