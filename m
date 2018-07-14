Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF667ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 07:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BC3208CC
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 07:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93BC3208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbeGNHWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 03:22:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:52513 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbeGNHWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 03:22:51 -0400
Received: from localhost ([123.218.192.122]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0M2XkX-1fwawD0Roz-00sKn1; Sat, 14
 Jul 2018 09:04:44 +0200
Date:   Sat, 14 Jul 2018 15:35:01 +0900 (JST)
Message-Id: <20180714.153501.1002564188152837590.teika@gmx.com>
To:     kitsunyan@inbox.ru
Cc:     dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics - Lenovo ThinkPad T25 and T480
 devices should use RMI
From:   Teika Kazura <teika@gmx.com>
In-Reply-To: <20180707051913.24035-1-kitsunyan@inbox.ru>
References: <20180707051913.24035-1-kitsunyan@inbox.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:cZ4llU1V43SQRSMuinLNvI+TutRpCOIy4Dg8JK8hXucCZjIluNO
 +LggtUoUOUYcgkIypwBsfvWGGEzIGrmphRqT53Fd6PYkyQS1ggp7rXhFnm90iru68dabpIg
 zAaQ2ZRA2nBTdD2XTGyaeY0tqHObXnlA1Hqa3xduh7eBUYaRQkcQiSRvE5oXoL+IPIIzNGR
 oDu0KqvUNpZw7ewuoWWLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:N/PyCM2ShIc=:xNxlGXFseWiURNhCAlNf2B
 8ZU7l9iTXlpZVKuH1spEPA2Xqk7JCLayNcJNp8RZ6OM7gKXVp1eYLz5JRZardr8pY+11SY/jS
 yqOsUN4qZwB41mmGYjRapVoBYuayn3rtljQ95eLpZVSlMr92c/nfJXw0zox4ZU90SUwP/5glu
 jLpKJ4LKdLL4BxDoB4GAfIpFK9DEKJxL6D0oxnCzP6/o2B8xqYcOrjDHJKKBiTce4zFeUev7T
 oHoi6JLGMGEpRgWpzADcfLa/8NDyVFVyQpYzwn0XjvFFF/0u9wy36crY0yHh2Va1dXPWiJlBq
 BLnB5SehffuaGMZ2XXkngT3dC2mZm8KDT3jHzFok4dMFKJA3I2o8HRbh5B4MKvtn0lRqAf1Z1
 EVViBvALadv657I/yKehwTU+1b51P+nzdxwjdJ8aosMu33IpX3Uid7MQOLiFiDRppx+vbYwL1
 XYhvUsrX86ilbbn9mZGMi4mtgFDZyOoPTyVBbDABhu4hnLIn449Fw7jgWSXdpKq31nnhyvLMT
 MYDt5Sgv320qifHGNM5QTPohMFdk/achMdikPUzhYWZY+1ve2KmkBy/o2H5YILzGGRkuaVw1l
 5EC/cWezkhBSgiS2iTsshyJh1+XxXj2DIPqR7rb1V1h6ZnQpY9TbxHvB6Rap8gKHF9p4Ys0hg
 YyT2jPlnyoeLb69sZB69jVxrJI8OoUzNJbmhOv/AFvNqyq9o6+NylKcJBCV2JhW+mi0UCQo0r
 ukcam4AIhb/kPOAH1aHmDqEMny2DzAPJv/0cqiKKKfBEb+dQ/wjaH2/biej82vzTHDej+Sd6S
 WhaFqmw
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIGtpdHN1bnlhbi4gKNCf0YDQuNCy0LXRgiwgcGVyaGFwcz8pIFRoYW5rcyBmb3IgeW91IHBh
dGNoLCBidXQgdGhlICJzaWduZWQtb2ZmIiB0YWcgbmVlZHMgeW91ciByZWFsIG5hbWUuIFlvdSBj
YW4gcmUtc3VibWl0IHlvdXIgcGF0Y2ggY29uZm9ybWluZyB0byB0aGF0IHJ1bGUuIE9yIGlmIHlv
dSdyZSBvaywgdGhlIGtlcm5lbCBtYWludGFpbmVyIGNhbiBpbnN0ZWFkIHNpZ24gaXQgb2ZmLCBh
ZGRpbmcgInJlcG9ydGVkLWJ5OiBraXRzdW55YW4gPGtpdHN1bnlhbkBpbmJveC5ydT4iLiAoSSdt
IG5vdCBzdXJlIGFib3V0IHRoZSBsYXR0ZXIgY2FzZS4gU29ycnkgaWYgSSdtIHdyb25nLikNCg0K
WW91IGNhbiBmaW5kIHRoZSBpbnN0cnVjdGlvbiBpbiA8a2VybmVsbCBzb3VyY2UgdHJlZT4vRG9j
dW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3QgLg0KDQpCZXN0IHJlZ2Fy
ZHMgLyDQn9C+0LrQsCwgDQpUZWlrYSAoVGVpa2Ega2F6dXJhKQ0KDQoNCkZyb206IGtpdHN1bnlh
biA8a2l0c3VueWFuQGluYm94LnJ1Pg0KU3ViamVjdDogW1BBVENIXSBJbnB1dDogc3luYXB0aWNz
IC0gTGVub3ZvIFRoaW5rUGFkIFQyNSBhbmQgVDQ4MCBkZXZpY2VzIHNob3VsZCB1c2UgUk1JDQpE
YXRlOiBTYXQsICA3IEp1bCAyMDE4IDA4OjE5OjEyICswMzAwDQoNCj4gVGhlIHRvdWNocGFkcyBv
biBib3RoIFQyNSBhbmQgVDQ4MCBhcmUgYWNjZXNzaWJsZSBvdmVyIFNNQlVTL1JNSS4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IGtpdHN1bnlhbiA8a2l0c3VueWFuQGluYm94LnJ1Pg0KPiAtLS0NCj4g
IGRyaXZlcnMvaW5wdXQvbW91c2Uvc3luYXB0aWNzLmMgfCAyICsrDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbnB1dC9tb3Vz
ZS9zeW5hcHRpY3MuYyBiL2RyaXZlcnMvaW5wdXQvbW91c2Uvc3luYXB0aWNzLmMNCj4gaW5kZXgg
NTVkMzM1MDBkNTVlLi5iZTkzNGEwODI0MjQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5wdXQv
bW91c2Uvc3luYXB0aWNzLmMNCj4gKysrIGIvZHJpdmVycy9pbnB1dC9tb3VzZS9zeW5hcHRpY3Mu
Yw0KPiBAQCAtMTc1LDcgKzE3NSw5IEBAIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3Qgc21idXNf
cG5wX2lkc1tdID0gew0KPiAgCSJMRU4wMDcxIiwgLyogVDQ4MCAqLw0KPiAgCSJMRU4wMDcyIiwg
LyogWDEgQ2FyYm9uIEdlbiA1ICgyMDE3KSAtIEVsYW4vQUxQUyB0cmFja3BvaW50ICovDQo+ICAJ
IkxFTjAwNzMiLCAvKiBYMSBDYXJib24gRzUgKEVsYW50ZWNoKSAqLw0KPiArCSJMRU4wMDhlIiwg
LyogVDI1ICovDQo+ICAJIkxFTjAwOTIiLCAvKiBYMSBDYXJib24gNiAqLw0KPiArCSJMRU4wMDkz
IiwgLyogVDQ4MCAqLw0KPiAgCSJMRU4wMDk2IiwgLyogWDI4MCAqLw0KPiAgCSJMRU4wMDk3Iiwg
LyogWDI4MCAtPiBBTFBTIHRyYWNrcG9pbnQgKi8NCj4gIAkiTEVOMjAwZiIsIC8qIFQ0NTBzICov
DQo+IC0tIA0KPiAyLjE4LjANCg==
