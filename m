Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD76ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D25921479
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=securecloudseven.com header.i=@securecloudseven.com header.b="jDwTlJ9f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D25921479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=securecloudseven.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733206AbeITVE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:04:29 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:47854 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732969AbeITVE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:04:29 -0400
Received: by mail-io1-f71.google.com with SMTP id v20-v6so11535435iom.14
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 08:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=securecloudseven.com; s=google;
        h=mime-version:message-id:date:subject:from:to
         :content-transfer-encoding;
        bh=dTiRduG4nSvRjNSrqx+5ofz7IoUrFPzfiTLNjGXSD2w=;
        b=jDwTlJ9fEzvV0Lf3fu7Rs9HgZgn31m3tgfkLUULX2v8hVHUY0Qs92qXYbH2m7UZeOS
         1fuHVIpiEC0Kj5nxv8KJs4RQ4gmkvfXMNR8XPivYXJBmcUomoeE5rpJlfS0SOjSWfhMO
         ArgDPgJB8wHxcPgz2zP4hQH4niRYBiOswetSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:message-id:date:subject:from:to
         :content-transfer-encoding;
        bh=dTiRduG4nSvRjNSrqx+5ofz7IoUrFPzfiTLNjGXSD2w=;
        b=bviRPMCgOEk2j72wlDYM3kHzzD8Y1pgvkDNQQSTKIMKH5vG1MHczjlO2cCEtm+EtES
         4oHAM9IPvAn4sdDa8H9JNZW5QFwwegKJZIitBax1Rf0dxsXq2+rzNDv4IK8k0zOVU06m
         DGHAiC/mqaqAm/bycMw5YnWwgRVAxXthsgUiYwD6juJPygZs4CZUKuUlhmvCa1eccE+w
         W9wPb6FSjexCqfT8F8NE0gNTcn59Aev+nPvk2Cqg3hgPqyUMlTeWMorvb0fKJyfhe7HI
         kyF0s4CrQrSAMb35wpFZ88i+U8PbRzODYJG9htIiLjSQcX5+DPKaEoRG6vcugPRu765b
         NMsg==
X-Gm-Message-State: APzg51Ct67fwbIsnqvmF9N4f76fmD85vTvL8D5SsMzA5KtFxXoyW5BHA
        fn+DsKyyxFAtQ3GZtMnaj+KCAWl6M1GT
X-Google-Smtp-Source: ANB0VdbPjAkw+n3vCBvlchBLwDjU18slvBGpExKntFI0fYKQUOozeHNNO7GrFwNBLkeL2uHjRxaGNjGugQ==
MIME-Version: 1.0
X-Received: by 2002:a5e:8d0b:: with SMTP id m11-v6mr31023706ioj.122.1537456830197;
 Thu, 20 Sep 2018 08:20:30 -0700 (PDT)
Message-ID: <00000000000038cbe705764f1092@google.com>
Date:   Thu, 20 Sep 2018 15:20:30 +0000
Subject:  IT Decision Makers Across the Globe 
From:   amanda.thompson@securecloudseven.com
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCkhvcGUgYWxsIGlzIHdlbGwhDQoNCldlIGFyZSBhIGRhdGFiYXNlIG9yZ2FuaXph
dGlvbi4gV2UgcHJvdmlkZSBidXNpbmVzcyBleGVjdXRpdmVzJyBjb250YWN0ICANCmluZm9ybWF0
aW9uLg0KDQpCZWxvdywgSSd2ZSBpbmNsdWRlZCBhIGZldyBleGFtcGxlczoNCg0KSW5kdXN0cnkt
U3BlY2lmaWMgTGlzdHM6IEFncmljdWx0dXJlLCBCdXNpbmVzcyBTZXJ2aWNlcywgQ2hhbWJlcnMg
b2YgIA0KQ29tbWVyY2UsIENpdGllcywgVG93bnMgJiBNdW5pY2lwYWxpdGllcywgQ29uc3RydWN0
aW9uLCBDb25zdW1lciBTZXJ2aWNlcywgIA0KQ3VsdHVyYWwsIEVkdWNhdGlvbiwgRW5lcmd5LCBV
dGlsaXRpZXMgJiBXYXN0ZSBUcmVhdG1lbnQsIEZpbmFuY2UsICANCkdvdmVybm1lbnQsIEhlYWx0
aGNhcmUsIEhvc3BpdGFsaXR5LCBJbnN1cmFuY2UsIExhdyBGaXJtcyAmIExlZ2FsIFNlcnZpY2Vz
LCAgDQpNYW51ZmFjdHVyaW5nLCBNZWRpYSAmIEludGVybmV0LCBNZXRhbHMgJiBNaW5pbmcsIE9y
Z2FuaXphdGlvbnMsIFJlYWwgIA0KRXN0YXRlLCBSZXRhaWwsIFNvZnR3YXJlLCBUZWxlY29tbXVu
aWNhdGlvbnMsIFRyYW5zcG9ydGF0aW9uLCBhbmQgbW9yZSENCg0KVGVjaG5vbG9neS1TcGVjaWZp
YyBMaXN0czogU0FQIHVzZXJzLCBQZW9wbGVTb2Z0IHVzZXJzLCBTSUVCRUwgY3VzdG9tZXJzLCAg
DQpPcmFjbGUgQXBwbGljYXRpb24gY3VzdG9tZXJzLCBNaWNyb3NvZnQgRHluYW1pYyB1c2Vycywg
U2FsZXMgZm9yY2UgdXNlcnMsICANCk1pY3Jvc29mdCBFeGNoYW5nZSB1c2VycywgUXVpY2tCb29r
cywgTGF3c29uIHVzZXJzLCBBY3QgdXNlcnMsIEpEIEVkd2FyZCAgDQp1c2VycywgQVNQIHVzZXJz
LCBNaWNyb3NvZnQgR1AgQXBwbGljYXRpb25zIHVzZXJzLCBOZXQgU3VpdGUgdXNlcnMsIElCTSAg
DQpEQk1TIEFwcGxpY2F0aW9uIHVzZXJzLCBNY0FmZWUgdXNlcnMsIE1TIER5bmFtaWNzIEdQIChH
cmVhdCBQbGFpbnMpLCBhbmQgIA0KbWFueSBtb3JlLg0KDQpUaXRsZS1TcGVjaWZpYyBMaXN0czog
Qy1sZXZlbCBleGVjdXRpdmVzOiBDRU8sIENGTywgQ0lPLCBDVE8sIENNTywgQ0lTTywgIA0KQ1NP
LCBDT08gS2V5IGRlY2lzaW9uLW1ha2VyczogQWxsIEMtbGV2ZWwsIFZQLWxldmVsLCBhbmQgRGly
ZWN0b3ItbGV2ZWwgIA0KZXhlY3V0aXZlcyBIUiBFeGVjdXRpdmVzOiBWUCBvZiBIUiwgSFIgRGly
ZWN0b3IgJiBIUiBNYW5hZ2VyLCBldGMuICAgDQpNYXJrZXRpbmcgRXhlY3V0aXZlczogQ01PLCBW
UCBvZiBNYXJrZXRpbmcsIERpcmVjdG9yIG9mIE1hcmtldGluZywgIA0KTWFya2V0aW5nIE1hbmFn
ZXJzIElUIEV4ZWN1dGl2ZXM6IENJTywgQ1RPLCBDSVNPLCBJVC1WUCwgSVQtRGlyZWN0b3IsIElU
ICANCk1hbmFnZXIsIE1JUyBNYW5hZ2VyLCBldGMuDQoNClBsZWFzZSBrZWVwIG1lIGluZm9ybWVk
IGZvciBhbnkgYWRkaXRpb25hbCBkZXRhaWxzLiBJIGxvb2sgZm9yd2FyZCB0byAgDQpoZWFyaW5n
IGZyb20geW91Lg0KDQpSZWdhcmRzLA0KQW1hbmRhDQpNYXJrZXRpbmcgRXhlY3V0aXZlDQoNCklm
IHlvdSBkb24ndCB3YW50IHRvIGluY2x1ZGUgeW91cnNlbGYgaW4gb3VyIG1haWxpbmcgbGlzdCwg
cGxlYXNlIHJlcGx5ICANCmJhY2sg4oCcTGVhdmUgT3V0IiIgaW4gYSBzdWJqZWN0IGxpbmUiDQo=
