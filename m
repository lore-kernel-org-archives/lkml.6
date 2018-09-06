Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53822C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3FC20844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=securecloudseven.com header.i=@securecloudseven.com header.b="nKD3T23d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3FC20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=securecloudseven.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbeIFWcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 18:32:54 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:36028 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbeIFWcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 18:32:53 -0400
Received: by mail-it0-f71.google.com with SMTP id m185-v6so13557941itm.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 10:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=securecloudseven.com; s=google;
        h=mime-version:message-id:date:subject:from:to
         :content-transfer-encoding;
        bh=VXmfNxFeC3t8/KckOEtG5DPP2kB0Dt5B/xDnaaJ3vXs=;
        b=nKD3T23dop5cGqffjz+CASzkM3sBpv9FeTyDb7RjTQzr7NodUrlhv97A2u7vpKATxx
         Ck45qLJ0iElgSONs7xjfLIbfdfwrCtXyyZKCQgfIhgS8kPVD3cZ4eUyk0b3x0D39BwJG
         oGhlfFcspRYzFMJxhtjjl0y9WBf0mJUTtZnsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:message-id:date:subject:from:to
         :content-transfer-encoding;
        bh=VXmfNxFeC3t8/KckOEtG5DPP2kB0Dt5B/xDnaaJ3vXs=;
        b=kK0TgfA5MjEpikxVP4nX+42X92atA1EKcCtfbM+nfMLFZTC1+UOPWz3YjsNZJMl4hi
         Y6dfEBjN4JW4jWAHbTbtzAb5eCywjSi0FhjIAf9v9uGb751ogyAOW8RLmAl2CTyuYo8H
         XNZhc0Chn9iPwIQjbzf38GhaxGyVIvflfIQNWSOkTQTAHsOMwfd4l2wUZi/J0zhfTRMt
         8Dk/qBfAPkJUTrLXSgxlQS2Q1eUNWbpqMGsWnJHBMPRNE1a5fYDGCCMF/D9M+RIdZuOw
         fQq5Y6AJ5ujsVKCoVjnTAGe9Qw/FJS3sWdsLw7dYyav9ZcvR1VdCp5cpPG+IpZLXDyY+
         +q5A==
X-Gm-Message-State: APzg51A3PQoUHDY5XkL/tXn/Yaqtg1L5Qyo8rVEMtGft4ezjlrDaO+We
        YIhdnnKUdoYSVj7ePiGjXXD3OosDmfdk
X-Google-Smtp-Source: ANB0VdZrmYUnQa5j21vUdCQwgZCmuqAHgX9xw4zvhMp/+RusPHwNLP1CeE5Z23nnNZhoRnx6cbx2TZKh7w==
MIME-Version: 1.0
X-Received: by 2002:a6b:8b58:: with SMTP id n85-v6mr3174827iod.138.1536256578139;
 Thu, 06 Sep 2018 10:56:18 -0700 (PDT)
Message-ID: <0000000000009fbc700575379bf2@google.com>
Date:   Thu, 06 Sep 2018 17:56:18 +0000
Subject: Targeted Global B2B Companies emails list
From:   christine.walker@securecloudseven.com
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkkganVzdCB3YW50ZWQgdG8gY2hlY2sgaWYgeW91IHdvdWxkIGJlIGludGVyZXN0ZWQg
aW4gYSBsaXN0IG9mIE1hbmFnZWQgIA0KU2VydmljZSBQcm92aWRlcnMgKE1TUHMpIGFuZCBNYW5h
Z2VkIFNlY3VyaXR5IFNlcnZpY2UgUHJvdmlkZXJzIChNU1NQcyk/DQoNCldlIGFsc28gaGF2ZSB0
aGUgZGF0YSBpbnRlbGxpZ2VuY2Ugb2Y6DQoNCuKAoiAgICAgICBNYW5hZ2VkIFNlcnZpY2UgUHJv
dmlkZXJzIChNU1DigJlzKSDigJMgMjUsMDAwIHVuaXF1ZSBjb21wYW5pZXMNCuKAoiAgICAgICBN
YW5hZ2VkIFNlY3VyaXR5IFNlcnZpY2UgUHJvdmlkZXJzIChNU1NQ4oCZcykg4oCTIDcsNTIwIHVu
aXF1ZSBjb21wYW5pZXMNCuKAoiAgICAgICBJVCBEZWNpc2lvbiBNYWtlcnMg4oCTIDZtaWxsaW9u
IGFjcm9zcyBhbGwgaW5kdXN0cnkNCuKAoiAgICAgICBCdXNpbmVzcyBEZWNpc2lvbiBNYWtlcnMg
4oCTIDEwIG1pbGxpb24gYWNyb3NzIGFsbCBpbmR1c3RyeQ0K4oCiICAgICAgIFZhbHVlIEFkZGVk
IFJlc2VsbGVycy0gVkFScw0K4oCiICAgICAgIEluZGVwZW5kZW50IFNvZnR3YXJlIFZlbmRvcnMt
IElTVnMNCuKAoiAgICAgICBTeXN0ZW0gSW50ZWdyYXRvcnMtIFNJcw0K4oCiICAgICAgIFZvSVAg
U2VydmljZSBQcm92aWRlcnMuDQrigKIgICAgICAgVGVsZWNvbW11bmljYXRpb25zIFNlcnZpY2Ug
UHJvdmlkZXJzIChUU1BzKQ0K4oCiICAgICAgIEFwcGxpY2F0aW9uIFNlcnZpY2UgUHJvdmlkZXJz
IChBU1BzKQ0K4oCiICAgICAgIElUIE1hbmFnZWQgU2VydmljZXMgUHJvdmlkZXJzIChJVE1TUCkN
CuKAoiAgICAgICBTdG9yYWdlIFNlcnZpY2UgUHJvdmlkZXJzIChTU1BzKQ0KDQpLaW5kbHkgcmV2
aWV3IGFuZCBsZXQgbWUga25vdyBpZiBJIGNhbiBzaGFyZSBtb3JlIGluZm9ybWF0aW9uIG9uIHRo
aXMuDQoNCkkgbG9vayBmb3J3YXJkIHRvIGhlYXJpbmcgZnJvbSB5b3UuDQoNClJlZ2FyZHMsDQpD
aHJpc3RpbmUNCk1hcmtldGluZyBTcGVjaWFsaXN0DQoNCklmIHlvdSBkb24ndCB3YW50IHRvIGlu
Y2x1ZGUgeW91cnNlbGYgaW4gb3VyIG1haWxpbmcgbGlzdCwgcGxlYXNlIHJlcGx5ICANCmJhY2sg
4oCcTGVhdmUgT3V0IiBpbiBhIHN1YmplY3QgbGluZQ0K
