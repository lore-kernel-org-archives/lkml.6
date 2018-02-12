Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934453AbeBLMV2 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:21:28 -0500
Received: from mailout.micron.com ([137.201.242.129]:37849 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932859AbeBLMV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:21:26 -0500
From: "Bean Huo (beanhuo)" <beanhuo@micron.com>
To: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: UFS writing request failure handling
Thread-Topic: UFS writing request failure handling
Thread-Index: AdOj+/zW760oQlBQQJyqdxucRpN8Rg==
Date: Mon, 12 Feb 2018 12:21:22 +0000
Message-ID: <2a98182c0eed4f0d9615982dc3733024@SIWEX5A.sing.micron.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.160.29.124]
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-23658.005
X-TM-AS-Result: No--7.663300-0.000000-31
X-TM-AS-MatchedID: 101405-187067-702187-701298-848362-705969-860493-106580-7
        07064-707163-700019-700648-708060-703283-106230-700107-148004-148050-148980
        -41000-42000-42003-29961
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
x-mt-checkinternalsenderrule: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
I am looking at UFS error handling, but I didn't notice re-issues requests with UTP error to the host controller.
According UFS host spec, "host software either completes the request that had the error and requests still outstanding 
with error to higher level software, or re-issues these requests to the host controller".
For the latest Linux UFS driver, it belongs to former one? 
If I am wrong, please correct me.
Thanks!
