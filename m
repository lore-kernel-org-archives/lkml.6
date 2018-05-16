Return-Path: <pmenzel@molgen.mpg.de>
X-Cyrus-Session-Id: sloti22d1t05-226318-1526474153-2-17747522996085755895
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
    1526474152; b=Kl5ly57yjBGRYRHm6raZ8nNp3rvPj8Fss3uecwUZV80UvHzxu+
    6nmjC35PTt705QV4+I0WQsvvsFPfgiiwSWVLgaa1ryjla0t8mJssSRQ2S++0ok8B
    BGoNBgVaJzvxmdURBOIygt6grpwQ0QpQGivVNJLJkiAb8jh/+d6aMBXZpPZm6grA
    gk2A4E9io0yxOYuxGZoS/5eKKkThs1h7T42Ei0kRYE36CyWo9+KbV49w8sulGuqu
    JuNSqDCsGfPaFOyYBgnc0o6d8MMfml6y4j8XLBYfox9aUjgvfw/YG7VN6lFVU8Bo
    1JxyILDaaOh1J8eQV7q4T3/pL6T96szBDdNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type; s=fm2; t=
    1526474152; bh=RC/d5t6WAeDN8IsTH4b3RUB18ylFIS4/8h5+ofOEaK0=; b=m
    H+Ys305RycOQsSlmopjV0V1EpCPlbcpd5g3JUQPFectoSIhVx+LHOi4NlPbTKYot
    pcFJYx4P3hf9gQFItASHaldSnarzvWB4mSYZO80O9EezHWvJ3ffQBwoH0byf/QX+
    /1N5Gyve7twqVsaZaZCndAIO7r/OAyJ8bmbKUAoLM5AAFnpw/e5ceXwKLeBe9/Fu
    gV/IN1JHub8Wgld7eLEr8FLskM5NcJTLDqZ6BdR3QeCvM8pPFfXNBYdtq8GVNlmu
    LJO6xYDz3piqt9PHdofPJGRe+BIHhruBgy9Ga+/Y5ahS26Yn008SRWcqgd8mpmq3
    RBQn5nq7ipqn5qxFQLt5g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfDPJYhV8Xj8bWy7i27aMs5FnI5sQFVSzqXR/88gUqhVPMElxDcP576y2fSHUHKOBM2zEv3UacfVDjGNzOwtusS4c54drrO1bZaFkLkgkHGfsH9uRDMCc
    B9s8zTCr9KTD5/LkVH+1Rhi0W1jsa8UxobvJetitJFApLTCxiPSxft+2yIpe04llx2BtuBQ+HK6a8g==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=aSyPyy6zf0jPBkF6nXIC4g==:117
    a=aSyPyy6zf0jPBkF6nXIC4g==:17 a=VUJBJC2UJ8kA:10 a=q0rX5H01Qin5IyBaTmIA:9
    a=iLNU1ar6AAAA:8 a=LdSbmKOsAAAA:8 a=VCuJx4pkCzbZYSDBPt0A:9 a=QEXdDO2ut3YA:10
    a=uhZEt4zlyJTvcZteQIkA:9 a=ZVk8-NSrHBgA:10 a=XVXkndj2wIAA:10
    a=HErAIEcT1t9lkSvq_S40:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Subject: Re: `ucsi_acpi: probe of USBC000:00 failed with error -12` on Dell
 XPS 13 9370
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg KH <greg@kroah.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mario Limonciello <mario.limonciello@dell.com>
References: <9365397f-7206-728e-ee76-146629bfd186@molgen.mpg.de>
 <20180515160047.GB26720@kroah.com>
 <69da4aa4-3d4b-0ffc-81ce-500713cd3743@molgen.mpg.de>
 <20180516080226.GC3536@kroah.com> <20180516115814.GB11469@kuha.fi.intel.com>
From: Paul Menzel <pmenzel+linux-usb@molgen.mpg.de>
Message-ID: <73e6e77b-36e0-017a-18fb-36e45b0a17a1@molgen.mpg.de>
Date: Wed, 16 May 2018 14:35:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180516115814.GB11469@kuha.fi.intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms090802040605080603060006"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms090802040605080603060006
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dear Heikki,


On 05/16/18 13:58, Heikki Krogerus wrote:

> On Wed, May 16, 2018 at 10:02:26AM +0200, Greg KH wrote:
>> On Tue, May 15, 2018 at 06:47:37PM +0200, Paul Menzel wrote:

>>> On 05/15/18 18:00, Greg KH wrote:
>>>> On Tue, May 15, 2018 at 04:34:03PM +0200, Paul Menzel wrote:
>>>
>>>>> Linux 4.17-rc5 shows the error below on the Dell XPS 13 9370 with D=
ebian
>>>>> Sid/unstable.
>>>>>
>>>>> ```
>>>>> [???]
>>>>> [    0.440240] usb: port power management may be unreliable
>>>>> [    0.441358] usbcore: registered new interface driver usb-storage=

>>>>> [    0.441367] usbcore: registered new interface driver usbserial_g=
eneric
>>>>> [    0.441369] usbserial: USB Serial support registered for generic=

>>>>> [    0.441383] ioremap error for 0x3f799000-0x3f79a000, requested 0=
x2, got
>>>>> 0x0
>>>>> [    0.441518] ucsi_acpi: probe of USBC000:00 failed with error -12=

>>>>> [???]
>>>>> ```
>>>>>
>>>>> 1.  Are the ioremap and ucsi_acpi error related or is a separate re=
port
>>>>> needed?
>>>>
>>>> The ioremap error is what causes ucsi_acpi to fail the probe call (-=
12
>>>> is "out of memory".)
>>>>
>>>>> 2.  Do you know the reason for the ucsi_acpi error?
>>>>
>>>> the call to ioremap failed.
>>>>
>>>> Does this device really have a working typec connector?
>>>
>>> Just to avoid misunderstandings, no device was connected to the lapto=
p
>>> during my test.
>>>
>>> But, from other boots, the Dell docking station TB16 kind of works wi=
th it,
>>> so I???d say the USB Type-C connector is working.
>>
>> Ok, good, this might just be the acpi tables not set up properly for
>> this type of connection.  Odd that the tables show it should work,
>> Heikki should know more about this.
>=20
> The firmware probable has not implemented UCSI on this board. I think
> Dell always supplies the ACPI device node for UCSI in their acpi
> tables. The _STA method in that device node is then used to inform the
> OS if the interface exists or not. The return value for _STA comes
> probable from BIOS, so this is most likely a BIOS problem.
>=20
> Please note that UCSI will only supply status information to the
> operating system, so the USB Type-C ports will function normally even
> without it. The ports are handled in firmware on these platforms.
>=20
> Paul, do you have the latest BIOS?

I had the latest firmware

 > DMI: Dell Inc. XPS 13 9370/0F6P3V, BIOS 1.2.1 02/21/2018

until today, when 1.3.2 with the changes below was released [1].

Mario, it=E2=80=99d be great, if the Dell firmware team could start testi=
ng with=20
Linux releases too to find such issues. Mario, could you please also=20
check internally if the Dell firmware team is aware of the issues and=20
can incorporate a fix. (I really wish the firmware would be free=20
software, so that these issues could be fixed ourselves.)

> Fixes & Enhancements
> Fixes:
> - Battery can't charge over 55%
> - Incorrect Ctrl+Alt+Del log on message with HID Event filter driver
> - Platform can't boot to the PXE boot environment in Legacy mode via DA=
300
> - Correct the flash utility string typo
> - PCIE Card error shows in Support Assist Tool
> - Fail 'PCR1 changed' msg prompt in CMD during running TPM PCR cycles i=
n OS
> - The PCI-to-PCI Bridge will lost while connecting to Dell Thunderbolt =
Dock TB18
> - Adjust fan speed
> - Skips keys when typing fast
>=20
> Enhancements:
> - None

It=E2=80=99ll take me up to some days to get my hands on the device again=
=2E But=20
the update should be easy enough thanks to Dell supporting fwupd with=20
UEFI Capsule and uploading their updates to the Linux Vendor Firmware=20
Service [2].


Kind regards,

Paul


[1]=20
http://www.dell.com/support/home/us/en/04/drivers/driversdetails?driverId=
=3DVF23P
[2] https://fwupd.org/


--------------ms090802040605080603060006
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
SIb3DQEJBTEPFw0xODA1MTYxMjM1NDhaMC8GCSqGSIb3DQEJBDEiBCAtgVpBoqpUAZvWwd7x
TZJAtFgQR2BRBxNbFb2Wr+8BxDBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGJBgkrBgEEAYI3EAQxfDB6MGoxCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxh
bmNrLUdlc2VsbHNjaGFmdDEVMBMGA1UEAwwMTVBHIENBIC0gRzAyAgweKlJIhfynPMVG/KIw
gYsGCyqGSIb3DQEJEAILMXygejBqMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREw
DwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxFTAT
BgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzFRvyiMA0GCSqGSIb3DQEBAQUABIIBALAR
yEcjW+0Rga6DkIVyNKNZ1s7wsv8MfYL6D2E7nYgMjytai/whMpLR12lCkCMZlQVoFpcELmU1
87Q2AsBHWbZSrZadhrFpl+pGmtH9XR5Gc7A2Thsm4r2IcgGBTKWE9V3Na0mts0W+OuavTdru
yJ/9Eeonb7n/o1dMIZOtBH/TXI/8Tir9SIfaItAZnNae3VFWl3FHrE9w4Fo/A7KS/o0Vop2q
ZKvBJ+1c5Rr7VffUtqmkzy3I5qJKARR6PU2kObZ4MAZIx8qfh+TnN6vXvJLsyAP44BZsPTpZ
14C3KCOH3d48oxOknM4sYkqNfpEnkhHOvK24ANo1mhKeTnMPpYgAAAAAAAA=
--------------ms090802040605080603060006--
