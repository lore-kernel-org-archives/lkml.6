Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753359AbeE3NHl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 09:07:41 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50167 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752645AbeE3NHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 09:07:36 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180530130734euoutp02054e20a55416a4b9fb4ace2c2e3ed1e4~zbgI5BEuv2658826588euoutp02B
X-AuditID: cbfec7f4-b4fc79c0000043e4-26-5b0ea214f8ee
Subject: Re: [PATCH 07/12] dt-bindings: tc358754: add DT bindings
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Maciej Purski <m.purski@samsung.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From: Andrzej Hajda <a.hajda@samsung.com>
Date: Wed, 30 May 2018 15:07:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1928297.lKUBOH9NhR@avalon>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3auDidnJ2svFZaTwIK8RNAX2Y2CDv1TBEUolMsOGjmNnbTs
        KpKhpja3Qp2iUYZmC2uZq3UBpzTtZsvKlExp0kUbldrNrtvOIv/7vd/zvs/7PvCxBJ9Hz2B3
        ZuwRDRm6dC2tJFvufO9aEH4mLCnObI7GJQ87FTivwEvhyxVNFK5tf0jhJ58/0Ng0YCTx25du
        Ep/wjBC4q+sSgx/kvWdwYVkdg22eZxTudlTTuKLrtgKfftdH4ovt/Qw+1+NW4Pxb7QyuML+j
        8XdHDbkyXLDWWJHQXVqiEK5b+hmhqqCSEmyNhbRg/zJICQPHXQrhSt0RobS5EQljtogNykRl
        wg4xfWe2aIhdnqxM6x59Tey2zd139L6Ui85GFKEQFrhF4HJ5GD/zXAOCjy8ii5DSx+MIvv7p
        RHIxhuDozRb630R3dbNCFuoRFBfdCRZeBIOtdsLfNZVbBT3njZSfwzkMJWfKA1YE94oC78jd
        gBXNzYNfV3oDTHJz4dvIDeTnadwWuGwcDRipODV0Vg6Rfg7houHNsDnABDcb7N5qQmYN9A3V
        Bq4ArpkFa8dZJA9ng33CTsp3r4H8CyZG5qkw7GoO8iy4Zy4O9kgweio3aJSLoKq+MygshTaX
        2xeH9W2bB02OWD+CL+VTEy9jGDz3quVzwsDUUk7IzyooOMbLHpEw8OAqIbMGzj36TBuR1jIp
        pGVSMMukYJb/a08jshFpxCxJnypKCzPEvTGSTi9lZaTGpGTqbcj3M+/9do1fQ46f252IY5E2
        VBW3RZXEU7psKUfvRMAS2nBV1q3QJF61Q5ezXzRkbjNkpYuSE81kSa1GtTX6cCLPper2iLtE
        cbdo+Kcq2JAZueggG6Gud2rX9+WrNx3wZsanLO9NqlJMsbDJbx2tlfyKzabVrfHlV588tsYm
        uNOdhRNu642TcX9Khz4mM6xgfLaEaFlS3JHn+VUate7QnG+fypr0s9bkNGyKmr5Ad6DA66y9
        OL0jRlr1eOJH79qeyCjP7eHQXcusG9vUej7ld4JmsZaU0nTx8wmDpPsLBHohg5UDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+85da3Gaih8SWiNTi6bT1E8xMSg5QaRRkqmxlh5UclvsbNKk
        SMygNM20i62xmWmgWOa20hQDxbxfUFNR6AJdrKbZvSSNnCvwvx88z++FFx4GF18nvZhMlZbX
        qBRZEsqV6PvT9XybW+Xa5KC5+o2oaLAHQ3nnZ0nUUF5PInPHIImefp+jUOmLEgK9ez5MoEuv
        7DgaGrpPo4G8GRpduFxFI8urcRKNNhspVD70GEMV76cIdLfjGY2qJ4YxdK61g0blZe8pNN9s
        ImLcuTpTHeBGi4sw7pHhGc3dPH+D5Cy1Fyiu8cdLkntR2IVx1qozXLGtFnBfLd7xrknSKI1a
        p+U3ZKgF7Q5JsgwFS2URSBq8PUIqCwk/EhkcKgmMjkrjszKzeU1g9FFpxuiXt/gJi+/J/H4h
        F9z2LgAuDGS3w1GjDSsAroyYrQaw19ZCOgNP2GKexZ3sBhfGCyhnyQ7g2JU7tCNwY3fCiZqS
        ZcGdRbCo8jpwlHD2LQk/DZj/GW0YrJj/uNyi2AC4aJ2kHCxio+G3qWvLlwjWF/6ytwAHe7CJ
        MM9URzs762DPjdeEg11Yfzj9oWyZcdYPLphGcCf7wMZZ4z/2hFOvzVgJEBtW6IYVimGFYlih
        VACiFrjzOkGZrhRkUkGhFHSqdGmqWmkBS6N42DlvbQIjDQfaAcsAyRpRUKIoWUwqsgW9sh1A
        Bpe4i3Sta5LFojSFPofXqOUaXRYvtIPQpecu414eqeqliam0clmoLBxFyMJDwkPCkMRTNBSk
        TxKz6Qotf5znT/Ca/x7GuHjlgqudDxZ67Rd1JD2wOsLHcGvvWfmwGZDr/eiwHFvG7LGt5pp4
        t9SEkfq430H3dvcFFI7lRwpMfExoomnB5Wdm4ODntgROrljcVWGV5/d7PWk+Fct0G8c2qeDB
        FL1/0ebGN4cLJrtXaanKssSR0/qZlEP79u/paZoqrY+btg1Px0oIIUMh24JrBMVfvziwESoD
        AAA=
Message-Id: <20180530130731eucas1p160d53c3f8500bcecd000bd8895843817~zbgGgQw3b1079710797eucas1p1H@eucas1p1.samsung.com>
X-CMS-MailID: 20180530130731eucas1p160d53c3f8500bcecd000bd8895843817
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180530123603epcas2p24f25097881c56b00ec9f81693924c38b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180530123603epcas2p24f25097881c56b00ec9f81693924c38b
References: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
        <2275901.CJI6BsfBlP@avalon>
        <20180530095915eucas1p27f09c8424d0c3c0619d134c5e7319fa3~zY7uP6Y6R1391213912eucas1p23@eucas1p2.samsung.com>
        <CGME20180530123603epcas2p24f25097881c56b00ec9f81693924c38b@epcas2p2.samsung.com>
        <1928297.lKUBOH9NhR@avalon>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.05.2018 14:35, Laurent Pinchart wrote:
> Hi Andrzej,
>
> On Wednesday, 30 May 2018 12:59:12 EEST Andrzej Hajda wrote:
>> On 28.05.2018 12:18, Laurent Pinchart wrote:
>>> On Monday, 28 May 2018 12:47:11 EEST Maciej Purski wrote:
>>>> The patch adds bindings to Toshiba DSI/LVDS bridge TC358764.
>>>> Bindings describe power supplies, reset gpio and video interfaces.
>>>>
>>>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>>>> Signed-off-by: Maciej Purski <m.purski@samsung.com>
>>>> ---
>>>>
>>>>  .../bindings/display/bridge/toshiba,tc358764.txt   | 42 ++++++++++++++++
>>>>  1 file changed, 42 insertions(+)
>>>>  create mode 100644
>>>>
>>>> Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
>>>> b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
>>>> new
>>>> file mode 100644
>>>> index 0000000..d09bdc2
>>>> --- /dev/null
>>>> +++
>>>> b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
>>>> @@ -0,0 +1,42 @@
>>>> +TC358764 MIPI-DSI to LVDS panel bridge
>>>> +
>>>> +Required properties:
>>>> +  - compatible: "toshiba,tc358764"
>>>> +  - reg: the virtual channel number of a DSI peripheral
>>>> +  - vddc-supply: core voltage supply
>>>> +  - vddio-supply: I/O voltage supply
>>>> +  - vddmipi-supply: MIPI voltage supply
>>>> +  - vddlvds133-supply: LVDS1 3.3V voltage supply
>>>> +  - vddlvds112-supply: LVDS1 1.2V voltage supply
>>> That's a lot of power supplies. Could some of them be merged together ?
>>> See https://patchwork.freedesktop.org/patch/216058/ for an earlier
>>> discussion on the same subject.
>> Specs says about 3 supply voltage values:
>> - 1.2V - digital core, DSI-RX PHY
>> - 1.8-3.3V - digital I/O
>> - 3.3V - LVDS-TX PHY
>>
>> So I guess it should be minimal number of supplies. Natural candidates:
>>
>> - vddc-supply: core voltage supply, 1.2V
>> - vddio-supply: I/O voltage supply, 1.8V or 3.3V
>> - vddlvds-supply: LVDS1/2 voltage supply, 3.3V
>>
>> I have changed name of the latest supply to be more consistent with
>> other supplies, and changed 1.8-3.3 (which incorrectly suggest voltage
>> range), to more precise voltage alternative.
> This looks fine to me.
>
>>>> +  - reset-gpios: a GPIO spec for the reset pin
>>>> +
>>>> +The device node can contain zero to two 'port' child nodes, each with
>>>> one
>>>> +child
>>>> +'endpoint' node, according to the bindings defined in [1].
>>>> +The following are properties specific to those nodes.
>>>> +
>>>> +port:
>>>> +  - reg: (required) can be 0 for DSI port or 1 for LVDS port;
>>> This seems pretty vague to me. It could be read as meaning that ports are
>>> completely optional, and that the port number you list can be used, but
>>> that something else could be used to.
>>>
>>> Let's make the port nodes mandatory. I propose the following.
>>>
>>> Required nodes:
>>>
>>> The TC358764 has DSI and LVDS ports whose connections are described using
>>> the OF graph bindings defined in
>>> Documentation/devicetree/bindings/graph.txt. The device node must contain
>>> one 'port' child node per DSI and LVDS port. The port nodes are numbered
>>> as follows.
>>>
>>>   Port                  Number
>>> -------------------------------------------------------------------
>>>   DSI Input             0
>>>   LVDS Output           1
>>>
>>> Each port node must contain endpoint nodes describing the hardware
>>> connections.
>> Since the bridge is controlled via DSI bus, DSI input port is not necessary.
> I don't agree with this. Regardless of how the bridge is controlled, I think 
> we should always use ports to describe the data connections. Otherwise it 
> would get more complicated for display controller drivers to use different 
> types of bridges.


It was discussed already, and DT guideline is to skip graphs in simple
case of parent/child nodes, see for example [1].

[1]: https://marc.info/?l=dri-devel&m=148354108702517&w=2

Regards
Andrzej

>>>> +[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
>>>> +
>>>> +Example:
>>>> +
>>>> +	bridge@0 {
>>>> +		reg = <0>;
>>>> +		compatible = "toshiba,tc358764";
>>>> +		vddc-supply = <&vcc_1v2_reg>;
>>>> +		vddio-supply = <&vcc_1v8_reg>;
>>>> +		vddmipi-supply = <&vcc_1v2_reg>;
>>>> +		vddlvds133-supply = <&vcc_3v3_reg>;
>>>> +		vddlvds112-supply = <&vcc_1v2_reg>;
>>>> +		reset-gpios = <&gpd1 6 GPIO_ACTIVE_LOW>;
>>>> +		#address-cells = <1>;
>>>> +		#size-cells = <0>;
>>>> +		port@1 {
>>>> +			reg = <1>;
>>>> +			lvds_ep: endpoint {
>>>> +				remote-endpoint = <&panel_ep>;
>>>> +			};
>>>> +		};
>>>> +	};
