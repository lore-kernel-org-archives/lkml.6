Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2740FC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DA7208CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6DA7208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935699AbeFMUcz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 16:32:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:47393 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935302AbeFMUcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 16:32:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2018 13:32:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,220,1526367600"; 
   d="p7s'?scan'208";a="236934070"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jun 2018 13:32:52 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 13 Jun 2018 13:32:52 -0700
Received: from orsmsx109.amr.corp.intel.com ([169.254.11.237]) by
 ORSMSX154.amr.corp.intel.com ([10.22.226.12]) with mapi id 14.03.0319.002;
 Wed, 13 Jun 2018 13:32:51 -0700
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "kevin.wangtao@linaro.org" <kevin.wangtao@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "javi.merino@kernel.org" <javi.merino@kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
Subject: Re: [PATCH V6] powercap/drivers/idle_injection: Add an idle
 injection framework
Thread-Topic: [PATCH V6] powercap/drivers/idle_injection: Add an idle
 injection framework
Thread-Index: AQHUAy7K0hOWsj2UDUW8/aeIJzxwIaRfEWGAgAAB54CAAAN5gIAAA5wA
Date:   Wed, 13 Jun 2018 20:32:50 +0000
Message-ID: <1528921968.48473.15.camel@intel.com>
References: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
         <1528905257.48473.4.camel@intel.com>
         <0b72e862-6bbe-e706-79f8-e1b690982920@linaro.org>
         <1528920447.48473.11.camel@intel.com>
         <ac38f5d9-80d1-09f2-6f8e-c58085f9a32a@linaro.org>
In-Reply-To: <ac38f5d9-80d1-09f2-6f8e-c58085f9a32a@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.31]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-gX4Zuh829QgnFnFjlDWj"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-gX4Zuh829QgnFnFjlDWj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-06-13 at 22:19 +0200, Daniel Lezcano wrote:
> On 13/06/2018 22:07, Pandruvada, Srinivas wrote:
> > On Wed, 2018-06-13 at 22:00 +0200, Daniel Lezcano wrote:
> > > On 13/06/2018 17:54, Pandruvada, Srinivas wrote:
> > > > On Tue, 2018-06-12 at 14:00 +0200, Daniel Lezcano wrote:
> > > > > Initially, the cpu_cooling device for ARM was changed by
> > > > > adding a
> > > > > new
> > > > > policy inserting idle cycles. The intel_powerclamp driver
> > > > > does a
> > > > > similar action.
> > > > >=20
> > > > > Instead of implementing idle injections privately in the
> > > > > cpu_cooling
> > > > > device, move the idle injection code in a dedicated framework
> > > > > and
> > > > > give
> > > > > the opportunity to other frameworks to make use of it.
> > > > >=20
> > > > > The framework relies on the smpboot kthreads which handles
> > > > > via
> > > > > its
> > > > > main loop the common code for hotplugging and [un]parking.
> > > > >=20
> > > > > This code was previously tested with the cpu cooling device
> > > > > and
> > > > > went
> > > > > through several iterations. It results now in split code and
> > > > > API
> > > > > exported in the header file. It was tested with the cpu
> > > > > cooling
> > > > > device
> > > > > with success.
> > > > >=20
> > > >=20
> > > > May be I have missed, but I don't see any use of powercap
> > > > sysfs.
> > > >=20
> > > > We created powercap sys that user space is presented a common
> > > > interface
> > > > for power capping. The RAPL driver was also submitted as
> > > > cooling
> > > > device
> > > > before, but suggestion was to create this powercap.
> > > >=20
> > > > So if powercap interface is not enough then may be we should
> > > > enhance
> > > > that.
> > >=20
> > > We are creating a framework for idle injection. This framework
> > > can
> > > then
> > > be used by the cpu_cooling device, the power_clamp and in
> > > addition a
> > > power capping for ARM (if it makes sense).
> >=20
> > But in this case, why in drivers/powercap folder as this is another
> > framework?
>=20
> I presented at OSPM 2nd the cpu idle cooling device. It is ARM
> specific
> but has some similarities with the power clamp driver.
>=20
> Some board come with power numbers defined in their DT and from there
> we
> are able to compute a targeted power by injecting idle cycles.
>=20
> As the idle injection allows to do also power capping, Rafael told me
> to
> move that to a framework (may be better say a component with exported
> services or library) and put it in drivers/powercap.
So Rafael wants it to be in powercap.

--=-gX4Zuh829QgnFnFjlDWj
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
aQGEV8ArjHXcotL/yLNh30JyB9sygYzIQadqyFvtvhUyiHwAh7Pf6Gl7Gsz0i/QSq7MK49JvgbUM
F1TCZwc7AgMBAAGjggI9MIICOTAdBgNVHQ4EFgQUf6YLVqF1vjXfk2h4J2GzgJAOB/8wHwYDVR0j
BBgwFoAUHmkqtNwo/kcYTiELP7ysES/wmPUwZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5p
bnRlbC5jb20vcmVwb3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWlu
ZyUyMENBJTIwNEEuY3JsMIGfBggrBgEFBQcBAQSBkjCBjzBpBggrBgEFBQcwAoZdaHR0cDovL3d3
dy5pbnRlbC5jb20vcmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJh
c2ljJTIwSXNzdWluZyUyMENBJTIwNEEuY3J0MCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5pbnRl
bC5jb20vMAsGA1UdDwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9
gSiFjp9TgpHACWeB3r05lfBDAgFkAgEJMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMM
MCkGCSsGAQQBgjcVCgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBXBgNVHREEUDBOoC0G
CisGAQQBgjcUAgOgHwwdc3Jpbml2YXMucGFuZHJ1dmFkYUBpbnRlbC5jb22BHXNyaW5pdmFzLnBh
bmRydXZhZGFAaW50ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQDDpWcY9zqtG5P0e1FRJpG/RPQ6
p6sQJHZ5UwykMtYFqBJYOZn9B8koeLEhE4vOAh6v6fgVoCfOvwxJ57BUAdP3jvkbCaLz3r6nUHNr
6w6KwnT9rHykdDjZsRUGs2yP+139qVqoXRHTOLfqvnAzcirjgf4Fz3JRPJZraRWrICBehqhYVfFH
sxxBgOauQ+DTHjZARkomjmrATvlDpLMlN74L/BKZI4rl4R/BjSaLBzAKQnAN0nvWefpPzdeSYuxK
XaN1xDzINPDnmShXSbQzee0h2CvEnIMtPQDM9DJACUi14Cc9y4o7DqRky4r1+XnksN2lKnu83l4E
oSxCkDMhszkFMYICFzCCAhMCAQEwgZAweTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYD
VQQHEwtTYW50YSBDbGFyYTEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIklu
dGVsIEV4dGVybmFsIEJhc2ljIElzc3VpbmcgQ0EgNEECEzMAAK0KIyEkTMbH5OYAAAAArQowCQYF
Kw4DAhoFAKBdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDYx
MzIwMzI0OFowIwYJKoZIhvcNAQkEMRYEFDeX0wOkTDlrJLZfrm+T8hVqNXMcMA0GCSqGSIb3DQEB
AQUABIIBALX/vN7hRcJ5Ehy9rOhAisjRdx0/UHt8KH6t8+OKbufbOzMBAWqnRhhVuqttr8VhtaH3
k0PjRLcfww0GJWsBgcFti7RYJuYpmw+Zr8gySuVGuEyiYYegYY3FSf6HCfIUGyt0vBJG4dFloEi3
w61up7n2Hz3aI1zLFABv7nYE6c40HwnPVlKHgGA4ZpOQuPB8RY1BvWpZ7VjuxELTyk3sWrZhz/qo
NXlaLSKn0E+XEz7rA2tZVD4uZ6SAXM19zIf7VUnctTQlHSKKbAQSCF9Y4uK3xs/cOlbXwf1/E+A3
6Jsz8mmpMVPE1NmoCp36AQfYfsXF2VNUBWUp+1mh1N5iHE0AAAAAAAA=


--=-gX4Zuh829QgnFnFjlDWj--
