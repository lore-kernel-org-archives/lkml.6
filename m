Return-Path: <pmenzel@molgen.mpg.de>
X-Cyrus-Session-Id: sloti22d1t05-2893015-1526402861-2-8455038183874637677
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='141.14.17.11', Host='mx3.molgen.mpg.de', Country='DE', FromHeader='de',
  MailFrom='de'
X-Spam-charsets: plain='utf-8'
X-Attached: smime.p7s
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: pmenzel@molgen.mpg.de
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526402861; b=IIseKm/H1ZnYcPPIhzS0CdnWYw/+tSVHtU+bHWo2SPgytAmx9K
    Uim6C1ax7F9Rnt/5BC8fi2TxhFPl0bko2DYg/NyIrfCEZFiaS35W/M6WoLygqPFe
    kvPCdJhM6HipXzBTX0CVNehOMfbw2Rza1QYhiYjc4ZcDwx/ogwyVIny2j1j9GDxG
    4UmOmJv9Zl2Onr8b0IsxNYK7qN50MhQqMzRkFws7kGPcqgwPj4EJMXavO6IKTjV9
    wnaF9ceEsGSEIL/XmojYkLvl1W4BRdpfaJroVSzfG7vFcDFW9BtG1nJb5rKHcS36
    UfuXY+7kt8aEA9d4wp9qJ4PoSi/1HuEhOdxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type; s=fm2; t=
    1526402861; bh=Pt5HAU9KoLjBgzQriBsQ0Bl9xDwnAahZImMFDSfHrCY=; b=Q
    83wS0NctYbVFBP7HWPc7IHsJtfF45Z6AlWs4xI2o8/JI4Hhnnk30wjSKmwHMI/mw
    eWVo1BDsvVAvndTtceboMw+dFh0DBqlGPZJsSHmLugP0gVOYjejxgSEFOmxqXWNI
    rSeo98N6HGKvqru+pKiddd8918QVqcB4nvaDbSZJ23j4f9rj2tn9J7Z5VS8x27df
    zpnPmhtkmin41fjEAu7kwtelC0N4TC+G7RvOpVAQOYcUyhuSToXBpGq2H9JSNn8I
    gdxkWsqmL2x9QMDDWO8DBx+qZQkQT1BKAhM3g527qmnNddUGPjpjtAXDC+WamKz3
    Byhip/DDVMb7GIzMPBiHg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=molgen.mpg.de;
    iprev=pass policy.iprev=141.14.17.11 (mx3.molgen.mpg.de);
    spf=pass smtp.mailfrom=pmenzel@molgen.mpg.de
    smtp.helo=mx1.molgen.mpg.de;
    x-aligned-from=domain_pass (Domain match);
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=mx1.molgen.mpg.de x-ptr-lookup=mx3.molgen.mpg.de;
    x-return-mx=pass smtp.domain=molgen.mpg.de smtp.result=pass
    smtp_org.domain=mpg.de smtp_org.result=pass smtp_is_org_domain=no
    header.domain=molgen.mpg.de header.result=pass
    header_org.domain=mpg.de header_org.result=pass
    header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=molgen.mpg.de;
    iprev=pass policy.iprev=141.14.17.11 (mx3.molgen.mpg.de);
    spf=pass smtp.mailfrom=pmenzel@molgen.mpg.de
      smtp.helo=mx1.molgen.mpg.de;
    x-aligned-from=domain_pass (Domain match);
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=mx1.molgen.mpg.de x-ptr-lookup=mx3.molgen.mpg.de;
    x-return-mx=pass smtp.domain=molgen.mpg.de smtp.result=pass
      smtp_org.domain=mpg.de smtp_org.result=pass smtp_is_org_domain=no
      header.domain=molgen.mpg.de header.result=pass
      header_org.domain=mpg.de header_org.result=pass
      header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJMbMGTIjow7beiiEWAiLre4izNeXS1dSVwBYN01D8hFEWLaZAeBN2F4cj8knvVbBgu5CvxmLE6ibaYQIR7vlIVBxZ4CjQwuHAlqF6PDOcgvBHU0+bYB
    x4o3EmAOL5x0cR2+6a5CiTmwYYUCsM7TN4ndFLTXSyOE+MbJ5EpLEo9ZSdCjjs1E5kiKQ8LYE2WPtA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=aSyPyy6zf0jPBkF6nXIC4g==:117
    a=aSyPyy6zf0jPBkF6nXIC4g==:17 a=VUJBJC2UJ8kA:10 a=q0rX5H01Qin5IyBaTmIA:9
    a=vcJbknBDYgwbv9CoT5gA:9 a=QEXdDO2ut3YA:10 a=uhZEt4zlyJTvcZteQIkA:9
    a=ZVk8-NSrHBgA:10 a=XVXkndj2wIAA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Subject: Re: `ucsi_acpi: probe of USBC000:00 failed with error -12` on Dell
 XPS 13 9370
To: Greg KH <greg@kroah.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mario Limonciello <mario.limonciello@dell.com>
References: <9365397f-7206-728e-ee76-146629bfd186@molgen.mpg.de>
 <20180515160047.GB26720@kroah.com>
From: Paul Menzel <pmenzel+linux-usb@molgen.mpg.de>
Message-ID: <69da4aa4-3d4b-0ffc-81ce-500713cd3743@molgen.mpg.de>
Date: Tue, 15 May 2018 18:47:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515160047.GB26720@kroah.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms040704040909040906040603"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms040704040909040906040603
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dear Greg,


As always, thank you for the prompt response.


On 05/15/18 18:00, Greg KH wrote:
> On Tue, May 15, 2018 at 04:34:03PM +0200, Paul Menzel wrote:

>> Linux 4.17-rc5 shows the error below on the Dell XPS 13 9370 with Debi=
an
>> Sid/unstable.
>>
>> ```
>> [=E2=80=A6]
>> [    0.440240] usb: port power management may be unreliable
>> [    0.441358] usbcore: registered new interface driver usb-storage
>> [    0.441367] usbcore: registered new interface driver usbserial_gene=
ric
>> [    0.441369] usbserial: USB Serial support registered for generic
>> [    0.441383] ioremap error for 0x3f799000-0x3f79a000, requested 0x2,=
 got
>> 0x0
>> [    0.441518] ucsi_acpi: probe of USBC000:00 failed with error -12
>> [=E2=80=A6]
>> ```
>>
>> 1.  Are the ioremap and ucsi_acpi error related or is a separate repor=
t
>> needed?
>=20
> The ioremap error is what causes ucsi_acpi to fail the probe call (-12
> is "out of memory".)
>=20
>> 2.  Do you know the reason for the ucsi_acpi error?
>=20
> the call to ioremap failed.
>=20
> Does this device really have a working typec connector?

Just to avoid misunderstandings, no device was connected to the laptop=20
during my test.

But, from other boots, the Dell docking station TB16 kind of works with=20
it, so I=E2=80=99d say the USB Type-C connector is working.

> Does normal USB devices work with it?

Sorry for being ignorant, but could you please tell me what normal USB=20
devices are?


Kind regards,

Paul


--------------ms040704040909040906040603
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EFowggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWNMIIEdaADAgECAgwcOtRQhH7u81j4jncwDQYJKoZIhvcNAQELBQAwgZUx
CzAJBgNVBAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1
dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNV
BAMTJERGTi1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjAeFw0xNjExMDMxNTI0
NDhaFw0zMTAyMjIyMzU5NTlaMGoxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZCYXllcm4xETAP
BgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDEVMBMG
A1UEAwwMTVBHIENBIC0gRzAyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnhx4
59Lh4WqgOs/Md04XxU2yFtfM15ZuJV0PZP7BmqSJKLLPyqmOrADfNdJ5PIGBto2JBhtRRBHd
G0GROOvTRHjzOga95WOTeura79T21FWwwAwa29OFnD3ZplQs6HgdwQrZWNi1WHNJxn/4mA19
rNEBUc5urSIpZPvZi5XmlF3v3JHOlx3KWV7mUteB4pwEEfGTg4npPAJbp2o7arxQdoIq+Pu2
OsvqhD7Rk4QeaX+EM1QS4lqd1otW4hE70h/ODPy1xffgbZiuotWQLC6nIwa65Qv6byqlIX0q
Zuu99Vsu+r3sWYsL5SBkgecNI7fMJ5tfHrjoxfrKl/ErTAt8GQIDAQABo4ICBTCCAgEwEgYD
VR0TAQH/BAgwBgEB/wIBATAOBgNVHQ8BAf8EBAMCAQYwKQYDVR0gBCIwIDANBgsrBgEEAYGt
IYIsHjAPBg0rBgEEAYGtIYIsAQEEMB0GA1UdDgQWBBTEiKUH7rh7qgwTv9opdGNSG0lwFjAf
BgNVHSMEGDAWgBST49gyJtrV8UqlkUrg6kviogzP4TCBjwYDVR0fBIGHMIGEMECgPqA8hjpo
dHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jcmwvY2Fjcmwu
Y3JsMECgPqA8hjpodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1
Yi9jcmwvY2FjcmwuY3JsMIHdBggrBgEFBQcBAQSB0DCBzTAzBggrBgEFBQcwAYYnaHR0cDov
L29jc3AucGNhLmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEoGCCsGAQUFBzAChj5odHRwOi8v
Y2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNy
dDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1j
YS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBABLpeD5FygzqOjj+
/lAOy20UQOGWlx0RMuPcI4nuyFT8SGmK9lD7QCg/HoaJlfU/r78ex+SEide326evlFAoJXIF
jVyzNltDhpMKrPIDuh2N12zyn1EtagqPL6hu4pVRzcBpl/F2HCvtmMx5K4WN1L1fmHWLcSap
dhXLvAZ9RG/B3rqyULLSNN8xHXYXpmtvG0VGJAndZ+lj+BH7uvd3nHWnXEHC2q7iQlDUqg0a
wIqWJgdLlx1Q8Dg/sodv0m+LN0kOzGvVDRCmowBdWGhhusD+duKV66pBl+qhC+4LipariWaM
qK5ppMQROATjYeNRvwI+nDcEXr2vDaKmdbxgDVwwggWvMIIEl6ADAgECAgweKlJIhfynPMVG
/KIwDQYJKoZIhvcNAQELBQAwajELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJheWVybjERMA8G
A1UEBwwITXVlbmNoZW4xIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MRUwEwYD
VQQDDAxNUEcgQ0EgLSBHMDIwHhcNMTcxMTE0MTEzNDE2WhcNMjAxMTEzMTEzNDE2WjCBizEL
MAkGA1UEBhMCREUxIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MTQwMgYDVQQL
DCtNYXgtUGxhbmNrLUluc3RpdHV0IGZ1ZXIgbW9sZWt1bGFyZSBHZW5ldGlrMQ4wDAYDVQQL
DAVNUElNRzEUMBIGA1UEAwwLUGF1bCBNZW56ZWwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDIh/UR/AX/YQ48VWWDMLTYtXjYJyhRHMc81ZHMMoaoG66lWB9MtKRTnB5lovLZ
enTIUyPsCrMhTqV9CWzDf6v9gOTWVxHEYqrUwK5H1gx4XoK81nfV8oGV4EKuVmmikTXiztGz
peyDmOY8o/EFNWP7YuRkY/lPQJQBeBHYq9AYIgX4StuXu83nusq4MDydygVOeZC15ts0tv3/
6WmibmZd1OZRqxDOkoBbY3Djx6lERohs3IKS6RKiI7e90rCSy9rtidJBOvaQS9wvtOSKPx0a
+2pAgJEVzZFjOAfBcXydXtqXhcpOi2VCyl+7+LnnTz016JJLsCBuWEcB3kP9nJYNAgMBAAGj
ggIxMIICLTAJBgNVHRMEAjAAMA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwHQYDVR0OBBYEFHM0Mc3XjMLlhWpp4JufRELL4A/qMB8GA1UdIwQYMBaA
FMSIpQfuuHuqDBO/2il0Y1IbSXAWMCAGA1UdEQQZMBeBFXBtZW56ZWxAbW9sZ2VuLm1wZy5k
ZTB9BgNVHR8EdjB0MDigNqA0hjJodHRwOi8vY2RwMS5wY2EuZGZuLmRlL21wZy1nMi1jYS9w
dWIvY3JsL2NhY3JsLmNybDA4oDagNIYyaHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzIt
Y2EvcHViL2NybC9jYWNybC5jcmwwgc0GCCsGAQUFBwEBBIHAMIG9MDMGCCsGAQUFBzABhido
dHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwQgYIKwYBBQUHMAKGNmh0
dHA6Ly9jZHAxLnBjYS5kZm4uZGUvbXBnLWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBC
BggrBgEFBQcwAoY2aHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzItY2EvcHViL2NhY2Vy
dC9jYWNlcnQuY3J0MEAGA1UdIAQ5MDcwDwYNKwYBBAGBrSGCLAEBBDARBg8rBgEEAYGtIYIs
AQEEAwYwEQYPKwYBBAGBrSGCLAIBBAMGMA0GCSqGSIb3DQEBCwUAA4IBAQCQs6bUDROpFO2F
Qz2FMgrdb39VEo8P3DhmpqkaIMC5ZurGbbAL/tAR6lpe4af682nEOJ7VW86ilsIJgm1j0ueY
aOuL8jrN4X7IF/8KdZnnNnImW3QVni6TCcc+7+ggci9JHtt0IDCj5vPJBpP/dKXLCN4M+exl
GXYpfHgxh8gclJPY1rquhQrihCzHfKB01w9h9tWZDVMtSoy9EUJFhCXw7mYUsvBeJwZesN2B
fndPkrXx6XWDdU3S1LyKgHlLIFtarLFm2Hb5zAUR33h+26cN6ohcGqGEEzgIG8tXS8gztEaj
1s2RyzmKd4SXTkKR3GhkZNVWy+gM68J7jP6zzN+cMYIDmjCCA5YCAQEwejBqMQswCQYDVQQG
EwJERTEPMA0GA1UECAwGQmF5ZXJuMREwDwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4
LVBsYW5jay1HZXNlbGxzY2hhZnQxFTATBgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzF
RvyiMA0GCWCGSAFlAwQCAQUAoIIB8TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0xODA1MTUxNjQ3MzdaMC8GCSqGSIb3DQEJBDEiBCCWCo+e81LrRbsC/Q7M
3okSMw59BTC11RVeKUIRRKPSuzBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGJBgkrBgEEAYI3EAQxfDB6MGoxCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxh
bmNrLUdlc2VsbHNjaGFmdDEVMBMGA1UEAwwMTVBHIENBIC0gRzAyAgweKlJIhfynPMVG/KIw
gYsGCyqGSIb3DQEJEAILMXygejBqMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREw
DwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxFTAT
BgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzFRvyiMA0GCSqGSIb3DQEBAQUABIIBAMff
j3hkKwn0ljiCeAt6ibJP2N1ex+g/ou9S7ZDNYJxB1WPmRLJPlnD4dDSksUoYxb+obQ2ymaOq
yyMCYxEnyutzaS4yUEjNXvJWZRHZZjznL/IpvYm3tcXwyRL0EH98IV/x0NfYsitni7n8npzf
QmWrG7QFOP1AVit0aJfD1la415n8XsNXRgXklaP9KbgceL3wh4T/28C/mapoPqgEWyZIMDU0
B6PwL25EMX1tJuM01k4N+tQ0eKxXSoh06EF6WOsZdImB6gFDTV7JaoTGhIbAOxuS0EL6P9aB
nTBThaiVHDCj8FcJnNeJ9yL6NzKJNelZWa4gkqYUucv1uyFM3zkAAAAAAAA=
--------------ms040704040909040906040603--
